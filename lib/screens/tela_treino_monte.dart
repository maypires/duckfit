import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../widgets/dados_treino_monte.dart';

class TelaTreinoMonte extends StatefulWidget {
  const TelaTreinoMonte({super.key});

  @override
  State<TelaTreinoMonte> createState() => _TelaTreinoMonteState();
}

class _TelaTreinoMonteState extends State<TelaTreinoMonte> {
  final List<String> diasSemana = [
    'Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'
  ];

  int diaSelecionado = DateTime.now().weekday % 7;

  // Mapa: dia -> lista de exercícios escolhidos
  final Map<int, List<Map<String, dynamic>>> treino = {};

  void adicionarExercicio(int dia, Map<String, dynamic> exercicio) {
    setState(() {
      treino.putIfAbsent(dia, () => []);
      treino[dia]!.add(exercicio);
    });
  }

  void editarExercicio(int dia, int index, Map<String, dynamic> novo) {
    setState(() {
      treino[dia]![index] = novo;
    });
  }

  void removerExercicio(int dia, int index) {
    setState(() {
      treino[dia]?.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final listaExercicios = treino[diaSelecionado] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monte seu treino'),
        backgroundColor: CoresApp.verdePrincipal,
      ),
      backgroundColor: CoresApp.fundo,
      body: Column(
        children: [
          // Tabs de dias da semana
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 12, bottom: 4),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: diasSemana.length,
              itemBuilder: (context, i) {
                final selecionado = diaSelecionado == i;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      diaSelecionado = i;
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
                        diasSemana[i],
                        style: TextStyle(
                          color: selecionado ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Lista de exercícios escolhidos para o dia selecionado
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text('Exercícios escolhidos:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: listaExercicios.length,
                    itemBuilder: (context, idx) {
                      final ex = listaExercicios[idx];
                      return ListTile(
                        title: Text(
                          ex['nome'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Séries: ${ex['series']} | Repetições: ${ex['repeticoes']} | Carga: ${ex['carga']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.amber, size: 20),
                              tooltip: 'Editar exercício',
                              onPressed: () async {
                                final novo = await showDialog<Map<String, dynamic>>(
                                  context: context,
                                  builder: (context) {
                                    final seriesCtrl = TextEditingController(text: ex['series'].toString());
                                    final repCtrl = TextEditingController(text: ex['repeticoes'].toString());
                                    final cargaCtrl = TextEditingController(text: ex['carga'].toString());
                                    return AlertDialog(
                                      backgroundColor: CoresApp.cinzaEscuro,
                                      title: Text('Editar ${ex['nome']}', style: const TextStyle(color: Colors.white)),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: seriesCtrl,
                                            decoration: const InputDecoration(labelText: 'Séries', labelStyle: TextStyle(color: Colors.white70)),
                                            keyboardType: TextInputType.number,
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          TextField(
                                            controller: repCtrl,
                                            decoration: const InputDecoration(labelText: 'Repetições', labelStyle: TextStyle(color: Colors.white70)),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          TextField(
                                            controller: cargaCtrl,
                                            decoration: const InputDecoration(labelText: 'Carga (ex: 20kg, corporal)', labelStyle: TextStyle(color: Colors.white70)),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Cancelar', style: TextStyle(color: Colors.white54)),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: CoresApp.verdePrincipal,
                                            foregroundColor: Colors.black,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context, {
                                              'nome': ex['nome'],
                                              'series': int.tryParse(seriesCtrl.text) ?? 3,
                                              'repeticoes': repCtrl.text,
                                              'carga': cargaCtrl.text,
                                            });
                                          },
                                          child: const Text('Salvar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                if (novo != null) {
                                  editarExercicio(diaSelecionado, idx, novo);
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => removerExercicio(diaSelecionado, idx),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Botão para adicionar exercício
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CoresApp.verdePrincipal,
                      foregroundColor: Colors.black,
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar exercício'),
                    onPressed: () async {
                      final exercicio = await showModalBottomSheet<Map<String, dynamic>>(
                        context: context,
                        backgroundColor: CoresApp.cinzaEscuro,
                        builder: (context) {
                          return ListView(
                            children: [
                              ...exerciciosDisponiveis.map((a) {
                                return ListTile(
                                  title: Text(a['nome'], style: const TextStyle(color: Colors.white)),
                                  onTap: () async {
                                    Navigator.pop(context, a);
                                  },
                                );
                              }).toList(),
                              ListTile(
                                leading: const Icon(Icons.add, color: Colors.greenAccent),
                                title: const Text('Adicionar novo exercício', style: TextStyle(color: Colors.greenAccent)),
                                onTap: () async {
                                  Navigator.pop(context);
                                  final novo = await showDialog<Map<String, dynamic>>(
                                    context: context,
                                    builder: (context) {
                                      final nomeCtrl = TextEditingController();
                                      final seriesCtrl = TextEditingController();
                                      final repCtrl = TextEditingController();
                                      final cargaCtrl = TextEditingController();
                                      return AlertDialog(
                                        backgroundColor: CoresApp.cinzaEscuro,
                                        title: const Text('Novo exercício', style: TextStyle(color: Colors.white)),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: nomeCtrl,
                                              decoration: const InputDecoration(labelText: 'Nome', labelStyle: TextStyle(color: Colors.white70)),
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                            TextField(
                                              controller: seriesCtrl,
                                              decoration: const InputDecoration(labelText: 'Séries', labelStyle: TextStyle(color: Colors.white70)),
                                              keyboardType: TextInputType.number,
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                            TextField(
                                              controller: repCtrl,
                                              decoration: const InputDecoration(labelText: 'Repetições', labelStyle: TextStyle(color: Colors.white70)),
                                              keyboardType: TextInputType.text,
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                            TextField(
                                              controller: cargaCtrl,
                                              decoration: const InputDecoration(labelText: 'Carga (ex: 20kg, corporal)', labelStyle: TextStyle(color: Colors.white70)),
                                              keyboardType: TextInputType.text,
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('Cancelar', style: TextStyle(color: Colors.white54)),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: CoresApp.verdePrincipal,
                                              foregroundColor: Colors.black,
                                            ),
                                            onPressed: () {
                                              if (nomeCtrl.text.isNotEmpty &&
                                                  seriesCtrl.text.isNotEmpty &&
                                                  repCtrl.text.isNotEmpty &&
                                                  cargaCtrl.text.isNotEmpty) {
                                                Navigator.pop(context, {
                                                  'nome': nomeCtrl.text,
                                                  'series': int.tryParse(seriesCtrl.text) ?? 3,
                                                  'repeticoes': repCtrl.text,
                                                  'carga': cargaCtrl.text,
                                                });
                                              }
                                            },
                                            child: const Text('Adicionar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (novo != null) {
                                    adicionarExercicio(diaSelecionado, novo);
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                      if (exercicio != null) {
                        final seriesCtrl = TextEditingController();
                        final repCtrl = TextEditingController();
                        final cargaCtrl = TextEditingController();
                        final preenchido = await showDialog<Map<String, dynamic>>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: CoresApp.cinzaEscuro,
                              title: Text('Configurar ${exercicio['nome']}', style: const TextStyle(color: Colors.white)),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: seriesCtrl,
                                    decoration: const InputDecoration(labelText: 'Séries', labelStyle: TextStyle(color: Colors.white70)),
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  TextField(
                                    controller: repCtrl,
                                    decoration: const InputDecoration(labelText: 'Repetições', labelStyle: TextStyle(color: Colors.white70)),
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  TextField(
                                    controller: cargaCtrl,
                                    decoration: const InputDecoration(labelText: 'Carga (ex: 20kg, corporal)', labelStyle: TextStyle(color: Colors.white70)),
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancelar', style: TextStyle(color: Colors.white54)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CoresApp.verdePrincipal,
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (seriesCtrl.text.isNotEmpty &&
                                        repCtrl.text.isNotEmpty &&
                                        cargaCtrl.text.isNotEmpty) {
                                      Navigator.pop(context, {
                                        'nome': exercicio['nome'],
                                        'series': int.tryParse(seriesCtrl.text) ?? 3,
                                        'repeticoes': repCtrl.text,
                                        'carga': cargaCtrl.text,
                                      });
                                    }
                                  },
                                  child: const Text('Adicionar'),
                                ),
                              ],
                            );
                          },
                        );
                        if (preenchido != null) {
                          adicionarExercicio(diaSelecionado, preenchido);
                        }
                      }
                    },
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
