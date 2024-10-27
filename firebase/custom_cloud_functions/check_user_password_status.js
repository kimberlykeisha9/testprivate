const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.checkUserPasswordStatus = functions.https.onCall(
  async (data, context) => {
    // Ensure that you handle the possibility of the 'email' parameter not being provided
    const email = data.email;
    if (!email) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        'The function must be called with one argument "email".',
      );
    }

    try {
      const userRecord = await admin.auth().getUserByEmail(email);
      // Assume password is set if user exists because Firebase Auth requires a password for email/password setups.
      return { passwordIsSet: true };
    } catch (error) {
      if (error.code === "auth/user-not-found") {
        // No user found, thus no password is set.
        return { passwordIsSet: false };
      }
      // Handle other possible errors
      console.error("Error fetching user data:", error);
      throw new functions.https.HttpsError(
        "unknown",
        "An unknown error occurred while checking user status",
      );
    }
  },
);
