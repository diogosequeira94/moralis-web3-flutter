import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralis_web3_flutter/cubit/wallet_information/wallet_information_cubit.dart';

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
                return Center(
                  child: Text(state.address.toString()),
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
