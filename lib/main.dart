import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moralis_web3_flutter/cubit/wallet_setup_cubit.dart';
import 'package:moralis_web3_flutter/data/storage/wallet_local_storage.dart';
import 'package:moralis_web3_flutter/view/create_or_import_account_page.dart';
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
          child: const CreateOrImportAccountPage()),
    );
  }
}
