import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  EthereumAddress getPublicKey(String privateKey);
}

class WalletProvider implements WalletAddressService {
  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    /// Pattern to generate public and private keys
    final seed = bip39.mnemonicToSeed(mnemonic);

    /// MasterKey to create Wallet
    final masterKey = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);

    /// Creates Private key by encoding MasterKey
    final privateKey = HEX.encode(masterKey.key);
    return privateKey;
  }

  @override
  EthereumAddress getPublicKey(String privateKey) {
    final ethPrivateKey = EthPrivateKey.fromHex(privateKey);
    final address = ethPrivateKey.address;
    return address;
  }
}
