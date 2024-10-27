const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.updateEnableDMinApp = functions.https.onCall(async (data, context) => {
  // Optional: Authentication check
  // if (!context.auth) {
  //     throw new functions.https.HttpsError('unauthenticated', 'The function must be called while authenticated.');
  // }

  try {
    // Ensure the 'newValue' parameter is provided and is a boolean
    if (data.newValue === undefined || typeof data.newValue !== "boolean") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        'The function must be called with a boolean "newValue" parameter.',
      );
    }

    // Retrieve the current Remote Config template
    const template = await admin.remoteConfig().getTemplate();

    // Update the 'EnableDMinApp' parameter
    template.parameters["EnableDMinApp"] = {
      defaultValue: { value: data.newValue ? "true" : "false" },
    };

    // Publish the updated template
    await admin.remoteConfig().publishTemplate(template);
    console.log("EnableDMinApp updated successfully to", data.newValue);
    return { result: "EnableDMinApp updated successfully" };
  } catch (error) {
    console.error("Error updating EnableDMinApp:", error);
    throw new functions.https.HttpsError(
      "unknown",
      "Failed to update EnableDMinApp",
      error,
    );
  }
});
