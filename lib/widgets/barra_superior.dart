import 'package:flutter/material.dart';
import '../theme/cores_app.dart';

class BarraSuperior extends StatelessWidget {
  const BarraSuperior({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36), // reduzido para evitar overflow
      child: Container(
        decoration: BoxDecoration(
          color: CoresApp.cinzaEscuro,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom:8), // padding menor
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/perfil.jpg'),
              radius: 23,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Bem-vindo!', style: TextStyle(color: Colors.white70, fontSize: 12)),
                Text(
                  'Chris Bumstead',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.menu, color: CoresApp.verdePrincipal),
          ],
        ),
      ),
    );
  }
}
