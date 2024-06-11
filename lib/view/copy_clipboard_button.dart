import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyClipBoardButton extends StatelessWidget {
  const CopyClipBoardButton({super.key, required this.textToCopy});
  final String textToCopy;

  void _copyToClipBoard() {
    Clipboard.setData(ClipboardData(text: textToCopy));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 65,
      child: ElevatedButton(
        onPressed: () {
          _copyToClipBoard();
          const snackBar = SnackBar(
            content: Text('Text copied to clipboard!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))),
        child: const Text(
          'Copy to Clipboard',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
