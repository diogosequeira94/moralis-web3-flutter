import 'package:flutter/material.dart';

class AssetsTab extends StatelessWidget {
  const AssetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _AssetCardItem(
            imagePath: 'assets/eth.png', ticker: 'ETH', amount: '444.2'),
        _AssetCardItem(
            imagePath: 'assets/hbar.png', ticker: 'HBAR', amount: '1231.5'),
        _AssetCardItem(
            imagePath: 'assets/xrd.png', ticker: 'XRD', amount: '500000'),
      ],
    );
  }
}

class _AssetCardItem extends StatelessWidget {
  final String imagePath;
  final String ticker;
  final String amount;
  const _AssetCardItem(
      {super.key,
      required this.imagePath,
      required this.ticker,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  imagePath,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 10.0),
                Text(
                  ticker,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
