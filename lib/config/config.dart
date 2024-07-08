import 'package:flutter/services.dart' show rootBundle;

class Config {
  static final Config _instance = Config._internal();

  factory Config() {
    return _instance;
  }

  Config._internal();

  late String baseUrl;
  late String organizationId;
  late String appId;
  late String apiKey;

  Future<void> load() async {
    final envString = await rootBundle.loadString('.env');
    final lines = envString.split('\n');
    for (var line in lines) {
      if (line.startsWith('BASE_URL=')) {
        baseUrl = line.substring('BASE_URL='.length);
      } else if (line.startsWith('ORGANIZATION_ID=')) {
        organizationId = line.substring('ORGANIZATION_ID='.length);
      } else if (line.startsWith('APP_ID=')) {
        appId = line.substring('APP_ID='.length);
      } else if (line.startsWith('API_KEY=')) {
        apiKey = line.substring('API_KEY='.length);
      }
    }
  }
}
