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
  late String? privateKey;

  @override
  void initState() {
    super.initState();
    _checkPrivateKey();
  }

  Future<void> _checkPrivateKey() async {
    preferences = await SharedPreferences.getInstance();
    privateKey = preferences.getString('privateKey');
  }

  void _navigateToNextPage() {
    final walletProvider = WalletProvider(walletStorage: WalletLocalStorage());
    Widget nextPage;
    if (privateKey != null) {
      nextPage = BlocProvider(
        create: (context) => WalletInformationCubit(
          walletProvider: walletProvider,
        )..loadWalletInformation(),
        child: const WalletInformationPage(),
      );
    } else {
      nextPage = BlocProvider(
        create: (context) => WalletCubit(
          walletProvider: walletProvider,
        ),
        child: const CreateOrImportAccountPage(),
      );
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return FadeTransition(
            opacity: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), _navigateToNextPage);
    });
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 250.0,
        ),
      ),
    );
  }
}
