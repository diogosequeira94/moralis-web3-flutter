import 'package:flutter/material.dart';
import 'package:moralis_web3_flutter/cubit/wallet_cubit.dart';
import 'package:moralis_web3_flutter/view/account_created_page.dart';
import 'wallet_provider.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (context) => WalletCubit(walletProvider: WalletProvider()),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                return ElevatedButton(
                  onPressed: () async {
                    context.read<WalletCubit>().createWallet();
                  },
                  child: Row(
                    children: [
                      const Text('Generate Wallet'),
                      if (state is WalletSetupInProgress)
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
