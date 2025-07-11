import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../widgets/botao_degrade.dart';
import '../widgets/barra_superior.dart';
import '../widgets/barra_inferior.dart';
import '../widgets/card_com_botao.dart';
import '../widgets/barra_lateral.dart';
import 'tela_dieta_nutri.dart';
import 'tela_dieta_monte.dart';

class TelaDieta extends StatelessWidget {
  final VoidCallback onNutriTap;
  final VoidCallback onMonteTap;
  final int indiceAtual;
  final Function(int) onTabSelected;
  final VoidCallback? onLogout;

  const TelaDieta({
    super.key,
    required this.onNutriTap,
    required this.onMonteTap,
    required this.indiceAtual,
    required this.onTabSelected,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BarraSuperior(),
      ),
      endDrawer: BarraLateral(onLogout: onLogout),
      backgroundColor: CoresApp.fundo,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CardComBotao(
              titulo: 'NUTRICIONISTA',
              descricao:
              'Plano alimentar desenvolvido especialmente para você, com foco nos seus objetivos, necessidades nutricionais e rotina.',
              imagem: 'assets/prato1.png',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TelaDietaNutri()),
                );
              },
            ),
            CardComBotao(
              titulo: 'MONTE SUA DIETA',
              descricao:
              'Você tem liberdade para escolher seus alimentos com base nas suas preferências, rotina e objetivos.',
              imagem: 'assets/prato2.png',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TelaDietaMonte()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BarraInferior(
        onTabSelected: onTabSelected,
        currentIndex: indiceAtual,
      ),
    );
  }
}
