import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnvironmentConfig {
  // we add the api key by running 'flutter run --dart-define=movieApiKey=MYKEY
  // final movieApiKey = const String.fromEnvironment('movieKey');

  // or get it from the .env file
  final movieApiKey = dotenv.env['MOVIEDB_KEY'];
}

final environmentConfigProvider =
    Provider<EnvironmentConfig>((ref) => EnvironmentConfig());
