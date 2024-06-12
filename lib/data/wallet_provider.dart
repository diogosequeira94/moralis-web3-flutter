import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:moralis_web3_flutter/data/storage/wallet_local_storage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> createPrivateKey(String mnemonic);
  EthereumAddress getPublicKey(String privateKey);
  Future<EthereumAddress?> getAddressFromStorage();
  Future<void> performLogout();
}

class WalletProvider implements WalletAddressService {
  final WalletStorage walletStorage;
  const WalletProvider({required this.walletStorage});

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> createPrivateKey(String mnemonic) async {
    /// Pattern to generate public and private keys
    final seed = bip39.mnemonicToSeed(mnemonic);

    /// MasterKey to create Wallet
    final masterKey = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);

    /// Creates Private key by encoding MasterKey
    final privateKey = HEX.encode(masterKey.key);

    /// Saves Private key in local storage
    await walletStorage.setPrivateKey(privateKey);
    return privateKey;
  }

  @override
  EthereumAddress getPublicKey(String privateKey) {
    final ethPrivateKey = EthPrivateKey.fromHex(privateKey);
    final address = ethPrivateKey.address;
    return address;
  }

  @override
  Future<EthereumAddress?> getAddressFromStorage() async {
    EthereumAddress? address;
    final privateKey = await walletStorage.loadPrivateKey();

    if (privateKey == null) {
      return null;
    } else {
      address = getPublicKey(privateKey);
      return address;
    }
  }

  @override
  Future<void> performLogout() async {
    await walletStorage.cleanUpStorage();
  }
}
