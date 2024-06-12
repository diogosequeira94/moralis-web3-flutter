part of 'wallet_information_cubit.dart';

abstract class WalletInformationState extends Equatable {
  const WalletInformationState();
}

class WalletInformationInitial extends WalletInformationState {
  @override
  List<Object> get props => [];
}

class WalletInformationInProgress extends WalletInformationState {
  @override
  List<Object> get props => [];
}

class WalletInformationLoaded extends WalletInformationState {
  final EthereumAddress? address;
  const WalletInformationLoaded(this.address);
  @override
  List<Object?> get props => [address];
}

class WalletInformationError extends WalletInformationState {
  @override
  List<Object> get props => [];
}

class WalletLogoutSuccess extends WalletInformationState {
  @override
  List<Object> get props => [];
}
