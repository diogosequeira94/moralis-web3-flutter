import 'package:flutter/material.dart';
import 'package:moralis_web3_flutter/view/copy_clipboard_button.dart';
import 'package:web3dart/web3dart.dart';

import 'common/standard_button.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // To prevent GridView from scrolling separately
                itemCount: mnemonicArray.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      '$index. ${mnemonicArray[index]}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              CopyClipBoardButton(textToCopy: mnemonic),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                child: Column(
                  children: [
                    Text('Private Key: $privateKey'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('Wallet Address: $address'),
                    ),
                  ],
                ),
              ),
              StandardButton(
                text: 'Next',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
