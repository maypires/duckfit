import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../widgets/dados_treino_duck.dart';

class TelaTreinoDuck extends StatefulWidget {
  const TelaTreinoDuck({super.key});

  @override
  State<TelaTreinoDuck> createState() => _TelaTreinoDuckState();
}

class _TelaTreinoDuckState extends State<TelaTreinoDuck> {
  int _diaSelecionado = DateTime.now().weekday % 7; // 0 = Domingo, 6 = Sábado

  final List<String> _diasSemana = [
    'Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'
  ];

  final Map<int, Set<int>> _expandidos = {};

  @override
  Widget build(BuildContext context) {
    final treinoDia = dadosTreinoDuck[_diaSelecionado] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Treino DuckFit'),
        backgroundColor: CoresApp.verdePrincipal,
      ),
      backgroundColor: CoresApp.fundo,
      body: Column(
        children: [
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
            child: treinoDia.isEmpty
                ? const Center(
                    child: Text(
                      'Sem treino para este dia.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    itemCount: treinoDia.length,
                    itemBuilder: (context, i) {
                      final musculo = treinoDia[i];
                      final expanded = _expandidos[_diaSelecionado]?.contains(i) ?? false;
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Card(
                          color: CoresApp.cinzaEscuro,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ListTile(
                                leading: musculo['imagem'] != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          musculo['imagem'],
                                          height: 72,
                                          width: 72,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : null,
                                title: Text(
                                  musculo['musculo'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: Icon(
                                  expanded ? Icons.expand_less : Icons.expand_more,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  setState(() {
                                    _expandidos[_diaSelecionado] ??= {};
                                    if (expanded) {
                                      _expandidos[_diaSelecionado]!.remove(i);
                                    } else {
                                      _expandidos[_diaSelecionado]!.add(i);
                                    }
                                  });
                                },
                              ),
                              if (expanded)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                                  child: Column(
                                    children: List.generate(
                                      (musculo['exercicios'] as List).length,
                                      (j) {
                                        final ex = musculo['exercicios'][j];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '• ${ex['nome']}',
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                'Séries: ${ex['series']}  |  Repetições: ${ex['repeticoes']}  |  Peso: ${ex['peso']}',
                                                style: const TextStyle(color: Colors.white60, fontSize: 14),
                                              ),
                                              if (ex['obs'] != null && ex['obs'].toString().isNotEmpty)
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 2),
                                                  child: Text(
                                                    'Obs: ${ex['obs']}',
                                                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
