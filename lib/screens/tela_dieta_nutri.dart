import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../widgets/dados_dieta_nutri.dart';

class TelaDietaNutri extends StatefulWidget {
  const TelaDietaNutri({super.key});

  @override
  State<TelaDietaNutri> createState() => _TelaDietaNutriState();
}

class _TelaDietaNutriState extends State<TelaDietaNutri> {
  int _diaSelecionado = DateTime.now().weekday % 7; // 0 = Domingo, 6 = Sábado

  final List<String> _diasSemana = [
    'Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'
  ];

  @override
  Widget build(BuildContext context) {
    final dietaDia = dadosDietaNutri[_diaSelecionado] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plano Nutricionista'),
        backgroundColor: CoresApp.verdePrincipal,
      ),
      backgroundColor: CoresApp.fundo,
      body: Column(
        children: [
          // Calendário semanal
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _diasSemana.length,
              itemBuilder: (context, index) {
                final selecionado = _diaSelecionado == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _diaSelecionado = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selecionado ? CoresApp.verdePrincipal : CoresApp.cinzaEscuro,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _diasSemana[index],
                        style: TextStyle(
                          color: selecionado ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ...['Café da manhã', 'Almoço', 'Lanche da tarde', 'Jantar', 'Ceia'].map((refeicao) {
                  final dados = dietaDia[refeicao];
                  return Card(
                    color: CoresApp.cinzaEscuro,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Lista de alimentos
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  refeicao,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (dados != null)
                                  ...List.generate(
                                    (dados['alimentos'] as List).length,
                                    (i) => Text(
                                      '• ${dados['alimentos'][i]}',
                                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                                    ),
                                  )
                                else
                                  const Text('Sem dados', style: TextStyle(color: Colors.white54)),
                              ],
                            ),
                          ),
                          // Macros em coluna vertical
                          if (dados != null)
                            Container(
                              margin: const EdgeInsets.only(left: 16, top: 4),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: CoresApp.verdePrincipal.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...dados['macros']
                                      .toString()
                                      .split('|')
                                      .map((macro) => Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 2),
                                            child: Text(
                                              macro.trim(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
