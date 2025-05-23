import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../widgets/botao_degrade.dart';
import '../widgets/barra_superior.dart';
import '../widgets/barra_inferior.dart';
import '../widgets/card_com_botao.dart';


class TelaDieta extends StatelessWidget {
  final VoidCallback onNutriTap;
  final VoidCallback onMonteTap;
  final int indiceAtual;
  final Function(int) onTabSelected;

  const TelaDieta({
    super.key,
    required this.onNutriTap,
    required this.onMonteTap,
    required this.indiceAtual,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BarraSuperior(),
      ),
      backgroundColor: CoresApp.fundo,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CardComBotao(
              titulo: 'NUTRICIONISTA',
              descricao:
              'Plano alimentar desenvolvido especialmente para você, com foco nos seus objetivos, necessidades nutricionais e rotina.',
              imagem: 'assets/dieta.jpg',
              onPressed: onNutriTap,
            ),
            CardComBotao(
              titulo: 'MONTE SUA DIETA',
              descricao:
              'Você tem liberdade para escolher seus alimentos com base nas suas preferências, rotina e objetivos.',
              imagem: 'assets/dieta.jpg',
              onPressed: onMonteTap,
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
