import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { dev, prod }

class EnvConstants {

  static final EnvConstants _instance = EnvConstants._internal();

  EnvConstants._internal();

  factory EnvConstants() {
    return _instance;
  }

  static Map<String, dynamic> _config = _Config.devConstants;

  static Future<void> initialize(Environment env) async{
    await dotenv.load(fileName: ".env");
    switch (env) {
      case Environment.dev:
        _config = _Config.devConstants;
        break;
      case Environment.prod:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get api => _config[_Config.api];
  static get amplitudeApiKey => _config[_Config.amplitudeApiKey];
  static get clarityApiKey => _config[_Config.clarityApiKey];
  static get kakaoNativeAppKey => _config[_Config.kakaoNativeAppKey];

}

class _Config {
  static const api = "API";
  static const amplitudeApiKey = "AMPLITUDE_API_KEY";
  static const kakaoNativeAppKey = "KAKAO_NATIVE_APP_KEY";
  static const clarityApiKey = "CLARITY_API_KEY";


  static Map<String, dynamic> devConstants = {
    api: dotenv.get('DEV'),
    amplitudeApiKey : 'dev',
    clarityApiKey : 'dev',
    kakaoNativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'),
  };

  static Map<String, dynamic> prodConstants = {
    api: dotenv.get('PROD'),
    amplitudeApiKey: dotenv.get('AMPLITUDE_API_KEY'),
    kakaoNativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'),
    clarityApiKey: dotenv.get('CLARITY_API_KEY'),
  };
}