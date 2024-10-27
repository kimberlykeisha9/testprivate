import 'package:firebase_remote_config/firebase_remote_config.dart';

Future initializeFirebaseRemoteConfig() async {
  try {
    await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await FirebaseRemoteConfig.instance.setDefaults(const {
      'AppBaseApiUrl': 'https://www.wisdomly.so',
      'AppLogoDark':
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/one-hundred-x-dxpmh3/assets/rz1vfk7gneab/100x.png',
      'AppSupportUrl': 'https://tribesocial.io/support',
      'Copy_Group': 'Group',
      'Copy_Groups': 'Groups',
      'TermsAndConditionsURL': 'https://pedroadao.com/terms-of-service/',
      'AppMuxBase64':
          'MDU5NDNkZDAtMDczYS00YWZkLTk4ZGEtYTQ4YmQ3M2VhMGRkOmh4dGVPWlNocm9HR3dIVmVsemFmVXRhajYwdVFpMlVtSkhCTnN1c3FmN3FySTh6RmJLT2hoWkUweXVndDJmY0YwL2dNK3FpR2JiRg==',
      'isGroupTypeEnabled': false,
      'GroupTypes':
          '[\"Member Education Center\",\"Signature Mastermind\",\"Testing Group 1\"]',
      'AppPlatformId': 1,
      'AppImgBaseUrl': 'https://ik.imagekit.io/wisdomly/',
      'UpdateAndroidAppURL':
          'https://play.google.com/store/apps/details?id=com.wisdomly.onehundredx&gl=US',
      'UpdateiOSAppURL':
          'https://apps.apple.com/us/app/100x-kingdom-entrepreneurship/id6443751894',
      'EnableDMinApp': false,
      'Feature_AllowExploreGroups': false,
      'Copy_Training': 'Curriculum',
      'Copy_Community': 'Community',
      'TicketsNotionClientId': '',
      'AppLogo': '',
      'AppSupportEmail': '',
      'AppLogoIcon': '',
      'cdnBaseUrl': 'https://cdn.tribesocial.io/',
      'hms_management_token': '',
      'hms_template': '670a6b961f1e5e9e0683543b',
      'hms_stream_url': '',
    });
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  } catch (error) {
    print(error);
  }
}

String getRemoteConfigString(String key) =>
    FirebaseRemoteConfig.instance.getString(key);

bool getRemoteConfigBool(String key) =>
    FirebaseRemoteConfig.instance.getBool(key);

int getRemoteConfigInt(String key) => FirebaseRemoteConfig.instance.getInt(key);

double getRemoteConfigDouble(String key) =>
    FirebaseRemoteConfig.instance.getDouble(key);
