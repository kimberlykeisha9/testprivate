const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.updateFeatureAllowExploreGroups = functions.https.onCall(
  async (data, context) => {
    // Authentication and validation checks...

    try {
      const template = await admin.remoteConfig().getTemplate();
      const boolValue = data.newValue;

      if (typeof boolValue !== "boolean") {
        throw new Error("newValue must be a boolean");
      }

      template.parameters["Feature_AllowExploreGroups"] = {
        defaultValue: { value: data.newValue ? "true" : "false" }, // Convert boolean to string
      };

      await admin.remoteConfig().publishTemplate(template);
      console.log(
        "Feature_AllowExploreGroups updated successfully to",
        boolValue,
      );
      return { result: "Feature_AllowExploreGroups updated successfully" };
    } catch (error) {
      console.error("Error updating Feature_AllowExploreGroups:", error);
      throw new functions.https.HttpsError(
        "unknown",
        "Failed to update Feature_AllowExploreGroups",
        error,
      );
    }
  },
);
