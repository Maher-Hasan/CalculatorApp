import 'package:flutter/material.dart';

// Helper method to build individual calculator buttons
Widget buildButton({required String label, required VoidCallback onPressed}) {
  return Expanded(
    // <-- Make the button take equal space within its Row
    child: AspectRatio(
      // <-- Maintain a square shape regardless of the of screen sizw
      aspectRatio: 1, // width : height = 1
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
            elevation: 6,
            backgroundColor: label == '=' ? Colors.orange : Colors.white,
            shadowColor: label == '=' ? Colors.orangeAccent : Colors.black45,
            foregroundColor: label == 'C' ? Colors.red : Colors.black,
            side: const BorderSide(color: Colors.grey),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(label, style: const TextStyle(fontSize: 24)),
          ),
        ),
      ),
    ),
  );
}
