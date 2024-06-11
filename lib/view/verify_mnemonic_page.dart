import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralis_web3_flutter/cubit/mnemonic/mnemonic_verification_cubit.dart';
import 'package:moralis_web3_flutter/view/common/standard_button.dart';

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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 3,
                    ),
                    itemBuilder: (context, index) {
                      final word = state.currentMnemonic[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: word.isEmpty
                            ? TextField(controller: textEditingController)
                            : Text(
                                '$index. $word',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                      );
                    },
                  );
                },
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
