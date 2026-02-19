import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.apple', obfuscate: true)
abstract class AppleEnv {
  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _AppleEnv.apiKey;
}

@Envied(path: '.env.banana', obfuscate: true)
abstract class BananaEnv {
  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _BananaEnv.apiKey;
}
