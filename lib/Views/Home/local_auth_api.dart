import 'package:demo/Views/Helper/log.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } catch (e) {
      logcat("Error checking biometrics:", e);
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      logcat("Error getting biometrics:", e);
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Use face to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
          sensitiveTransaction: true,
        ),
      );
    } catch (e) {
      logcat("Error during authentication:", e);
      return false;
    }
  }
}
