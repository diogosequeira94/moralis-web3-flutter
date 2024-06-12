import 'package:flutter/material.dart';

class WalletInformationHeader extends StatelessWidget {
  const WalletInformationHeader({super.key, required this.address, required this.balance});

  final String address;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Wallet Address',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Text(
          address,
          style: const TextStyle(
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32.0),
        const Text(
          'Balance',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Text(
          balance,
          style: const TextStyle(
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
