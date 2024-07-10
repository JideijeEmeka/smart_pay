import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartpay/helpers/constants.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future deletePin() async => await _storage.delete(key: kPinIdentifier);

  static Future setPin(String pin) async => await _storage.write(key: kPinIdentifier, value: pin);

  static Future<String?> getPin() async => await _storage.read(key: kPinIdentifier);
}