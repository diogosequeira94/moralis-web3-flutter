import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mnemonic_verification_state.dart';

class MnemonicVerificationCubit extends Cubit<MnemonicVerificationState> {
  MnemonicVerificationCubit(this.mnemonic)
      : super(MnemonicVerificationState(
          currentMnemonic: mnemonic,
          isMnemonicCorrect: false,
        ));

  final List<String> mnemonic;

  void setupRandomMnemonic() {
    final List<String> copyList = List.from(mnemonic);
    final mnemonicLength = mnemonic.length;
    final random = Random();

    // Sets a set to store unique indices
    Set<int> uniqueIndices = {};

    // Generate unique random indices
    while (uniqueIndices.length < 3) {
      uniqueIndices.add(random.nextInt(mnemonicLength));
    }

    // Convert the set to a list
    List<int> indicesList = uniqueIndices.toList();

    // Replace the words at those indices with empty strings
    for (int index in indicesList) {
      copyList[index] = '';
    }

    emit(state.copyWith(currentMnemonic: copyList));
  }
}
