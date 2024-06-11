import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralis_web3_flutter/cubit/wallet_information/wallet_information_cubit.dart';
import 'package:moralis_web3_flutter/view/wallet_information/wallet_information_header.dart';

class WalletInformationPage extends StatelessWidget {
  const WalletInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WalletInformationCubit, WalletInformationState>(
            builder: (context, state) {
              if (state is WalletInformationInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WalletInformationLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WalletInformationHeader(
                            address: state.address.toString(),
                            balance: 400.toString(),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  FloatingActionButton(
                                    heroTag:
                                        'sendButton', // Unique tag for send button
                                    onPressed: () {},
                                    child: const Icon(Icons.send),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text('Send'),
                                ],
                              ),
                              Column(
                                children: [
                                  FloatingActionButton(
                                    heroTag:
                                        'refreshButton', // Unique tag for send button
                                    onPressed: () {},
                                    child: const Icon(Icons.replay_outlined),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text('Refresh'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
