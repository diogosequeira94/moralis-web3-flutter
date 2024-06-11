part of 'wallet_setup_cubit.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  @override
  List<Object> get props => [];
}

class WalletSetupInProgress extends WalletState {
  @override
  List<Object> get props => [];
}

class WalletSetupSuccess extends WalletState {
  final String mnemonic;
  final String privateKey;
  final EthereumAddress ethereumAddress;

  const WalletSetupSuccess({
    required this.mnemonic,
    required this.privateKey,
    required this.ethereumAddress,
  });

  @override
  List<Object> get props => [
        mnemonic,
        privateKey,
        ethereumAddress,
      ];
}

class WalletSetupFailure extends WalletState {
  @override
  List<Object> get props => [];
}
