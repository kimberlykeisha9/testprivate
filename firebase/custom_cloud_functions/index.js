const admin = require("firebase-admin/app");
admin.initializeApp();

const updateNullCategories = require("./update_null_categories.js");
exports.updateNullCategories = updateNullCategories.updateNullCategories;
const updateFeatureAllowExploreGroups = require("./update_feature_allow_explore_groups.js");
exports.updateFeatureAllowExploreGroups =
  updateFeatureAllowExploreGroups.updateFeatureAllowExploreGroups;
const updateEnableDMinApp = require("./update_enable_d_min_app.js");
exports.updateEnableDMinApp = updateEnableDMinApp.updateEnableDMinApp;
const updateIsGroupTypeEnabled = require("./update_is_group_type_enabled.js");
exports.updateIsGroupTypeEnabled =
  updateIsGroupTypeEnabled.updateIsGroupTypeEnabled;
const checkUserPasswordStatus = require("./check_user_password_status.js");
exports.checkUserPasswordStatus =
  checkUserPasswordStatus.checkUserPasswordStatus;
const createThumbnailFromUploadedVideo = require("./create_thumbnail_from_uploaded_video.js");
exports.createThumbnailFromUploadedVideo =
  createThumbnailFromUploadedVideo.createThumbnailFromUploadedVideo;
const webhookReceiver = require("./webhook_receiver.js");
exports.webhookReceiver = webhookReceiver.webhookReceiver;
