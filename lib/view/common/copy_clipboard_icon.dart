import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyClipBoardIcon extends StatelessWidget {
  const CopyClipBoardIcon({super.key, required this.textToCopy});
  final String textToCopy;

  void _copyToClipBoard() {
    Clipboard.setData(ClipboardData(text: textToCopy));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Icon(Icons.copy),
      onTap: () {
        _copyToClipBoard();

        const snackBar = SnackBar(
          content: Text('Text copied to clipboard!'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
