import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../screens/tela_login.dart';
import '../screens/config.dart';

class BarraLateral extends StatelessWidget {
  final VoidCallback? onLogout;
  const BarraLateral({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CoresApp.cinzaEscuro,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/perfil.jpg'),
              radius: 40,
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Chris Bumstead',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Center(
              child: Text(
                'chris.bumstead@email.com',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
            const Divider(color: Colors.white24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Peso: 102 kg', style: TextStyle(color: Colors.white, fontSize: 15)),
                  SizedBox(height: 4),
                  Text('Altura: 1,85 m', style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.settings, color: CoresApp.verdePrincipal),
              title: const Text('Configurações', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pop(); // Fecha o Drawer
                // Use pushReplacement para garantir navegação correta pelo main.dart
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => TelaConfig(
                      onTabSelected: (index) {
                        Navigator.of(context).pop();
                      },
                      indiceAtual: 4,
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoresApp.verdePrincipal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o Drawer
                  if (onLogout != null) {
                    onLogout!();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
