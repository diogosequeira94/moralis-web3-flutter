import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralis_web3_flutter/cubit/wallet_information/wallet_information_cubit.dart';
import 'package:moralis_web3_flutter/cubit/wallet_setup_cubit.dart';
import 'package:moralis_web3_flutter/data/storage/wallet_local_storage.dart';
import 'package:moralis_web3_flutter/data/wallet_provider.dart';
import 'package:moralis_web3_flutter/view/create_or_import_account_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'wallet_information/wallet_information_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  late SharedPreferences preferences;
  @override
  void initState() async {
    super.initState();
    preferences = await SharedPreferences.getInstance();
    final privateKey = preferences.getString('privateKey');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        final walletProvider = WalletProvider(walletStorage: WalletLocalStorage());
        if (privateKey != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => WalletInformationCubit(
                  walletProvider: walletProvider,
                )..loadWalletInformation(),
                child: const WalletInformationPage(),
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => WalletCubit(
                  walletProvider: walletProvider,
                ),
                child: const CreateOrImportAccountPage(),
              ),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 50.0,
        ),
      ),
    );
  }
}
