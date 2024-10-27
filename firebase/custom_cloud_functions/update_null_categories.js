const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.updateNullCategories = functions.firestore
  .document("broadcasts/{broadcastId}")
  .onWrite(async (change, context) => {
    const document = change.after.exists ? change.after.data() : null;

    // Proceed if the document exists and the category is missing or is [null]
    if (document && (!document.category || document.category.includes(null))) {
      const broadcastsRef = change.after.ref;

      try {
        // Set the category to ["All"]
        await broadcastsRef.update({
          category: ["All"],
        });
        console.log(
          `Updated category for document ${context.params.broadcastId}`,
        );
      } catch (error) {
        console.error(
          `Error updating category for document ${context.params.broadcastId}`,
          error,
        );
      }
    }
  });
