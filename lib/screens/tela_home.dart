import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../widgets/card_opcao.dart';
import '../widgets/grafico_progresso.dart';
import '../widgets/barra_superior.dart';
import '../widgets/barra_inferior.dart';

class TelaHome extends StatelessWidget {
  final Function(int) onCardTap;
  final int indiceAtual;
  final Function(int) onTabSelected;

  const TelaHome({
    super.key,
    required this.onCardTap,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ...removido o header antigo...
            Row(
              children: [
                Expanded(
                  child: CardOpcao(
                    titulo: 'Dieta',
                    caminhoImagem: 'assets/dieta.jpg',
                    icone: Icons.restaurant,
                    onTap: () => onCardTap(0),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CardOpcao(
                    titulo: 'Treino',
                    caminhoImagem: 'assets/treino.jpg',
                    icone: Icons.fitness_center,
                    onTap: () => onCardTap(1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CoresApp.cinzaEscuro,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Objetivo', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Hipertrofia - Ganho de massa', style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('70kg - 85kg', style: TextStyle(color: Colors.white54)),
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 150, child: GraficoProgresso()),
                ],
              ),
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
