import 'package:flutter/material.dart';

class CardOpcao extends StatelessWidget {
  final String titulo;
  final String caminhoImagem;
  final IconData icone;
  final VoidCallback onTap;

  const CardOpcao({
    super.key,
    required this.titulo,
    required this.caminhoImagem,
    required this.icone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                caminhoImagem,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Icon(icone, color: Colors.white),
            ),
            const Positioned(
              top: 140,
              right: 5,
              child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
