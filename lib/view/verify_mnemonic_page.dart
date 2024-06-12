import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralis_web3_flutter/cubit/mnemonic/mnemonic_verification_cubit.dart';
import 'package:moralis_web3_flutter/cubit/wallet_information/wallet_information_cubit.dart';
import 'package:moralis_web3_flutter/data/storage/wallet_local_storage.dart';
import 'package:moralis_web3_flutter/data/wallet_provider.dart';
import 'package:moralis_web3_flutter/view/common/standard_button.dart';
import 'package:moralis_web3_flutter/view/wallet_information/wallet_information_page.dart';

class VerifyMnemonicPage extends StatefulWidget {
  const VerifyMnemonicPage({super.key});

  @override
  State<VerifyMnemonicPage> createState() => _VerifyMnemonicPageState();
}

class _VerifyMnemonicPageState extends State<VerifyMnemonicPage> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mnemonic Verification'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<MnemonicVerificationCubit, MnemonicVerificationState>(
                builder: (context, state) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // To prevent GridView from scrolling separately
                    itemCount: state.currentMnemonic.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 3,
                    ),
                    itemBuilder: (context, index) {
                      final word = state.currentMnemonic[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: word.isEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${index + 1}.',
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: TextField(
                                        controller: textEditingController,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  '${index + 1}. $word',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                        ),
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: StandardButton(
                  text: 'Verify',
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 10.0),
              StandardButton(
                text: 'Next',
                onTap: () {
                  /// ToDo: Create a Registry to have a singleton
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => WalletInformationCubit(
                            walletProvider: WalletProvider(
                              walletStorage: WalletLocalStorage(),
                            ),
                          )..loadWalletInformation(),
                          child: const WalletInformationPage(),
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
