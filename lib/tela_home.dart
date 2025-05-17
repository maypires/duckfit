import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'main.dart';

class _Card extends StatelessWidget {
  final String titulo;
  final String caminhoImagem;
  final IconData icone;

  const _Card({
    required this.titulo,
    required this.caminhoImagem,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    /*
    Cria um card quadrado com uma imagem de fundo. 
    Adiciona um título no canto superior esquerdo e um ícone no canto superior direito.
    O card tem bordas arredondadas e uma camada escura para dar contraste no texto/ícone.
    */
    return AspectRatio(
      aspectRatio: 1, // Faz o card ser quadrado
      child: Stack(
        children: [
          // Imagem de fundo
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              caminhoImagem,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Camada escura para dar contraste no texto/ícone
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          // Texto (título) no canto superior esquerdo
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
          // Ícone no canto superior direito
          Positioned(
            top: 10,
            right: 10,
            child: Icon(icone, color: Colors.white),
          ),
          Positioned(
            top: 140,
            right: 5,
            child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}

class TelaHome extends StatelessWidget {
  final Function(int) onCardTap;

  const TelaHome({super.key, required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    //Contrói o cabeçalho da tela inicial do aplicativo.
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho com foto e saudação
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/perfil.jpg'),
                radius: 25,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Bem-vindo!', style: TextStyle(color: Colors.white70)),
                  Text(
                    'Chris Bumstead',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.menu, color: Colors.greenAccent),
            ],
          ),

          const SizedBox(height: 24),
          // Cards de dieta e treino
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Acessa o estado ancestral _HomeScreenState e atualiza o índice
                    final homeState =
                        context.findAncestorStateOfType<HomeScreenState>();
                    homeState?.onItemTapped(1); // 1 para 'TelaDieta'
                  },
                  child: _Card(
                    titulo: 'Dieta',
                    caminhoImagem: 'assets/dieta.jpg',
                    icone: Icons.restaurant,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final homeState =
                        context.findAncestorStateOfType<HomeScreenState>();
                    homeState?.onItemTapped(2); // 2 para 'TelaTreino'
                  },
                  child: _Card(
                    titulo: 'Treino',
                    caminhoImagem: 'assets/treino.jpg',
                    icone: Icons.fitness_center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Card com objetivo e gráfico de progresso
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Objetivo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Hipertrofia - Ganho de massa',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '70kg - 85kg',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                const SizedBox(height: 16),

                // Gráfico de linha (peso ao longo dos meses)
                SizedBox(
                  height: 150,
                  child: LineChart(
                    LineChartData(
                      minY: 65,
                      maxY: 85,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine:
                            (value) =>
                                FlLine(color: Colors.white24, strokeWidth: 1),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 5,
                            reservedSize: 32,
                            getTitlesWidget:
                                (value, _) => Text(
                                  '${value.toInt()}kg',
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 10,
                                  ),
                                ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, _) {
                              const meses = [
                                'JAN',
                                'FEV',
                                'MAR',
                                'ABR',
                                'MAI',
                                'JUN',
                                'JUL',
                              ];
                              if (value.toInt() >= 0 &&
                                  value.toInt() < meses.length) {
                                return Text(
                                  meses[value.toInt()],
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 10,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 70), // JAN
                            FlSpot(1, 75), // FEV
                            FlSpot(2, 72), // MAR
                            FlSpot(3, 73), // ABR
                            FlSpot(4, 78), // MAI
                            FlSpot(5, 77), // JUN
                            FlSpot(6, 80), // JUL
                          ],
                          isCurved: true,
                          color: Colors.greenAccent,
                          barWidth: 4,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.greenAccent.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
