import 'package:flutter/material.dart';
import '../theme/cores_app.dart';

class BarraSuperior extends StatefulWidget {
  const BarraSuperior({super.key});

  @override
  State<BarraSuperior> createState() => _BarraSuperiorState();
}

class _BarraSuperiorState extends State<BarraSuperior> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 36),
        child: Container(
          decoration: BoxDecoration(
            color: CoresApp.cinzaEscuro,
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 0),
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
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
              IconButton(
                icon: const Icon(Icons.menu, color: CoresApp.verdePrincipal),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
