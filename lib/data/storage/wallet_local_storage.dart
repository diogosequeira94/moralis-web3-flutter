import 'package:shared_preferences/shared_preferences.dart';

abstract class WalletStorage {
  Future<String?> loadPrivateKey();
  Future<void> setPrivateKey(String privateKey);
  Future<void> cleanUpStorage();
}

class WalletLocalStorage implements WalletStorage {
  final privateKeyString = 'privateKey';
  @override
  Future<String?> loadPrivateKey() async {
    final preferences = await SharedPreferences.getInstance();
    final privateKey = preferences.getString(privateKeyString);
    return privateKey;
  }

  @override
  Future<void> setPrivateKey(String privateKey) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(privateKeyString, privateKey);
  }

  @override
  Future<void> cleanUpStorage() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(privateKeyString);
  }
}
