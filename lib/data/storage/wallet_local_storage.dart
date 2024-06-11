import 'package:shared_preferences/shared_preferences.dart';

abstract class WalletStorage {
  Future<String?> loadPrivateKey();
  Future<void> setPrivateKey(String privateKey);
}

class WalletLocalStorage implements WalletStorage {
  @override
  Future<String?> loadPrivateKey() async {
    final preferences = await SharedPreferences.getInstance();
    final privateKey = preferences.getString('privateKey');
    return privateKey;
  }

  @override
  Future<void> setPrivateKey(String privateKey) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('privateKey', privateKey);
  }
}
