import 'package:flutter/material.dart';
import '../theme/cores_app.dart';

class BotaoDegrade extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const BotaoDegrade({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            CoresApp.verdePrincipal,
            CoresApp.verdeAgua,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
