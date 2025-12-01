// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env')
abstract class Env {
  @EnviedField(varName: 'PayPalSecretKey', obfuscate: true)
  static String paypalSecretKey = _Env.paypalSecretKey;

  @EnviedField(varName: 'PayPalClientId', obfuscate: true)
  static String paypalClientId = _Env.paypalClientId;

  @EnviedField(varName: 'FirebaseProjectId', obfuscate: true)
  static String firebaseProjectId = _Env.firebaseProjectId;

  @EnviedField(varName: 'StripePublishKey', obfuscate: true)
  static String stripePublishKey = _Env.stripePublishKey;

  @EnviedField(varName: 'StripeSecretKey', obfuscate: true)
  static String stripeSecretKey = _Env.stripeSecretKey;
  @EnviedField(varName: 'MapKey', obfuscate: true)
  static String mapKey = _Env.mapKey;
}
