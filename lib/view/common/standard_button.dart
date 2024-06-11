import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  const StandardButton({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
