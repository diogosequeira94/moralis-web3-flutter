import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moralis_web3_flutter/cubit/transactions/transactions_cubit.dart';
import 'package:moralis_web3_flutter/view/common/standard_button.dart';
import 'package:web3dart/web3dart.dart';

class SendTokensPage extends StatefulWidget {
  final String privateKey;

  const SendTokensPage({super.key, required this.privateKey});

  @override
  State<SendTokensPage> createState() => _SendTokensPageState();
}

class _SendTokensPageState extends State<SendTokensPage> {
  late TextEditingController recipientController;
  late TextEditingController amountController;

  @override
  void initState() {
    amountController = TextEditingController();
    recipientController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Tokens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                'assets/eth.png',
                width: 225,
                height: 225,
              ),
            ),
            TextField(
              controller: recipientController,
              decoration: const InputDecoration(
                labelText: 'Recipient Address',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 32.0),
            StandardButton(
              onTap: () {
                final recipient = recipientController.text;
                final amount = double.parse(amountController.text);
                final bigIntValue = BigInt.from(amount * pow(10, 18));
                final ethAmount =
                    EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue);
                context
                    .read<TransactionsCubit>()
                    .sendTransaction('myPrivateKey', recipient, ethAmount);
              },
              text: 'Send',
            ),
          ],
        ),
      ),
    );
  }
}
