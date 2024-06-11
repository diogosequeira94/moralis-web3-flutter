import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moralis_web3_flutter/cubit/wallet_cubit.dart';
import 'package:moralis_web3_flutter/data/storage/wallet_local_storage.dart';
import 'package:moralis_web3_flutter/view/account_created_page.dart';
import 'data/wallet_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (context) => WalletCubit(
              walletProvider:
                  WalletProvider(walletStorage: WalletLocalStorage())),
          child: const MoralisPage(title: 'Flutter Demo For Moralis API')),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FlutterLogo(size: 175),
            const SizedBox(height: 50),
            BlocConsumer<WalletCubit, WalletState>(
              listener: (context, state) {
                if (state is WalletSetupSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountCreatedPage(
                              mnemonic: state.mnemonic,
                              privateKey: state.privateKey,
                              address: state.ethereumAddress,
                            )),
                  );
                } else if (state is WalletSetupFailure) {
                  const snackBar = SnackBar(
                    content: Text('Oops, something went wrong!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: 250,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () async {
                      context.read<WalletCubit>().createWallet();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Create Wallet',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        if (state is WalletSetupInProgress)
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 250,
              height: 65,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Customize button background color
                    foregroundColor:
                        Colors.black, // Customize button text color
                    padding: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                child: const Text(
                  'Import from Seed',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
