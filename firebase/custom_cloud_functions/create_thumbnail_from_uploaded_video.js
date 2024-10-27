const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const { Storage } = require("@google-cloud/storage");
const ffmpeg = require("fluent-ffmpeg");
const path = require("path");
const os = require("os");
const fs = require("fs");
const axios = require("axios");

// The default app initialization by Firebase Functions environment
// admin.initializeApp(); // This line is intentionally commented out

const storage = new Storage();

exports.createThumbnailFromUploadedVideo = functions.firestore
  .document("broadcasts/{docId}")
  .onCreate(async (snap, context) => {
    const data = snap.data();
    const videoUrl = data.video;
    const featuredImage = data.featuredImage;

    if (!videoUrl || featuredImage) {
      console.log("No video to process or featured image already exists.");
      return null;
    }

    const tempFilePath = path.join(os.tmpdir(), path.basename(videoUrl));

    try {
      // Download the video
      const response = await axios({
        url: videoUrl,
        method: "GET",
        responseType: "stream",
      });

      const writer = fs.createWriteStream(tempFilePath);

      response.data.pipe(writer);

      await new Promise((resolve, reject) => {
        writer.on("finish", resolve);
        writer.on("error", reject);
      });

      // Extract the first frame using ffmpeg
      const imageFileName = `frame-${context.params.docId}.jpg`;
      const imageTempPath = path.join(os.tmpdir(), imageFileName);

      await new Promise((resolve, reject) => {
        ffmpeg(tempFilePath)
          .on("end", resolve)
          .on("error", reject)
          .screenshots({
            timestamps: ["0"],
            filename: imageFileName,
            folder: os.tmpdir(),
            size: "320x240",
          });
      });

      // Obtain the default bucket for the current project
      const bucketName = admin.storage().bucket().name;

      // Upload the extracted frame to Cloud Storage
      await storage.bucket(bucketName).upload(imageTempPath, {
        destination: imageFileName,
      });

      const fileUrl = `https://storage.googleapis.com/${bucketName}/${imageFileName}`;

      // Update Firestore with the image URL
      await snap.ref.update({
        featuredImage: fileUrl,
      });

      // Cleanup temporary files
      fs.unlinkSync(tempFilePath);
      fs.unlinkSync(imageTempPath);

      console.log("Image uploaded and Firestore updated successfully.");
    } catch (error) {
      console.error("Error processing video:", error);
      // The error handling will now just log the error.
    }

    return null;
  });
