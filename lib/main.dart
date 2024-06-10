import 'package:flutter/material.dart';
import 'wallet_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MoralisPage(title: 'Flutter Demo For Moralis API'),
    );
  }
}

class MoralisPage extends StatefulWidget {
  const MoralisPage({super.key, required this.title});
  final String title;

  @override
  State<MoralisPage> createState() => _MoralisPageState();
}

class _MoralisPageState extends State<MoralisPage> {
  @override
  Widget build(BuildContext context) {
    final walletProvider = WalletProvider();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final mnemonic = walletProvider.generateMnemonic();
                final privateKey = await walletProvider.getPrivateKey(mnemonic);
                final publicKey = walletProvider.getPublicKey(privateKey);

                print('Mnemonic: $mnemonic');
                print('Private Key: $privateKey');
                print('Public Key: $publicKey');
              },
              child: const Text('Generate Wallet'),
            )
          ],
        ),
      ),
    );
  }
}
