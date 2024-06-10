import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class AccountCreatedPage extends StatelessWidget {
  final String mnemonic;
  final String privateKey;
  final EthereumAddress address;

  const AccountCreatedPage({
    super.key,
    required this.mnemonic,
    required this.privateKey,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final mnemonicArray = mnemonic.split(' ');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet Creation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (final words in mnemonicArray)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(words),
              ),
            Text('Private Key: $privateKey'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text('Wallet Address: $address'),
            ),
          ],
        ),
      ),
    );
  }
}
