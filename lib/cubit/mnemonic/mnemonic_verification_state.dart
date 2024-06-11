part of 'mnemonic_verification_cubit.dart';

class MnemonicVerificationState extends Equatable {
  final List<String> currentMnemonic;
  final bool? isMnemonicCorrect;
  const MnemonicVerificationState({
    required this.currentMnemonic,
    required this.isMnemonicCorrect,
  });

  MnemonicVerificationState copyWith({
    List<String>? currentMnemonic,
    bool? isMnemonicCorrect,
  }) {
    return MnemonicVerificationState(
      currentMnemonic: currentMnemonic ?? this.currentMnemonic,
      isMnemonicCorrect: isMnemonicCorrect ?? this.isMnemonicCorrect,
    );
  }

  @override
  List<Object?> get props => [currentMnemonic, isMnemonicCorrect];
}
