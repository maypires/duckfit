import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../widgets/dados_dieta_monte.dart';

class TelaDietaMonte extends StatefulWidget {
  const TelaDietaMonte({super.key});

  @override
  State<TelaDietaMonte> createState() => _TelaDietaMonteState();
}

class _TelaDietaMonteState extends State<TelaDietaMonte> {
  final List<String> refeicoes = [
    'Café da manhã',
    'Almoço',
    'Lanche da tarde',
    'Jantar',
    'Ceia'
  ];

  int refeicaoSelecionada = 0;

  // Mapa: refeição -> lista de alimentos escolhidos
  final Map<String, List<Map<String, dynamic>>> dieta = {};

  void adicionarAlimento(String refeicao, Map<String, dynamic> alimento, {String quantidade = ''}) {
    setState(() {
      dieta.putIfAbsent(refeicao, () => []);
      final novoAlimento = Map<String, dynamic>.from(alimento);
      novoAlimento['quantidade'] = quantidade;
      dieta[refeicao]!.add(novoAlimento);
    });
  }

  void editarQuantidade(String refeicao, int index, String novaQuantidade) {
    setState(() {
      dieta[refeicao]![index]['quantidade'] = novaQuantidade;
    });
  }

  void removerAlimento(String refeicao, int index) {
    setState(() {
      dieta[refeicao]?.removeAt(index);
    });
  }

  Map<String, int> calcularMacrosDia() {
    int p = 0, c = 0, g = 0;
    dieta.forEach((_, alimentos) {
      for (var a in alimentos) {
        p += a['proteina'] as int;
        c += a['carbo'] as int;
        g += a['gordura'] as int;
      }
    });
    return {'proteina': p, 'carbo': c, 'gordura': g};
  }

  @override
  Widget build(BuildContext context) {
    final macrosDia = calcularMacrosDia();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monte sua dieta'),
        backgroundColor: CoresApp.verdePrincipal,
      ),
      backgroundColor: CoresApp.fundo,
      body: Column(
        children: [
          // Tabs de refeições
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: refeicoes.length,
              itemBuilder: (context, i) {
                final selecionada = refeicaoSelecionada == i;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      refeicaoSelecionada = i;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selecionada ? CoresApp.verdePrincipal : CoresApp.cinzaEscuro,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        refeicoes[i],
                        style: TextStyle(
                          color: selecionada ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Lista de alimentos escolhidos para a refeição
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text('Alimentos escolhidos:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: dieta[refeicoes[refeicaoSelecionada]]?.length ?? 0,
                    itemBuilder: (context, idx) {
                      final alimento = dieta[refeicoes[refeicaoSelecionada]]![idx];
                      return ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                alimento['nome'] +
                                    (alimento['quantidade'] != null && alimento['quantidade'].toString().isNotEmpty
                                        ? ' (${alimento['quantidade']})'
                                        : ''),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.amber, size: 20),
                              tooltip: 'Editar quantidade',
                              onPressed: () async {
                                final controller = TextEditingController(text: alimento['quantidade'] ?? '');
                                final novaQuantidade = await showDialog<String>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: CoresApp.cinzaEscuro,
                                      title: const Text('Editar quantidade', style: TextStyle(color: Colors.white)),
                                      content: TextField(
                                        controller: controller,
                                        decoration: const InputDecoration(
                                          labelText: 'Quantidade (ex: 2 fatias, 100g, 1 copo)',
                                          labelStyle: TextStyle(color: Colors.white70),
                                        ),
                                        style: const TextStyle(color: Colors.white),
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
                                            Navigator.pop(context, controller.text);
                                          },
                                          child: const Text('Salvar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                if (novaQuantidade != null) {
                                  editarQuantidade(refeicoes[refeicaoSelecionada], idx, novaQuantidade);
                                }
                              },
                            ),
                          ],
                        ),
                        subtitle: Text(
                          'P: ${alimento['proteina']}g | C: ${alimento['carbo']}g | G: ${alimento['gordura']}g',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => removerAlimento(refeicoes[refeicaoSelecionada], idx),
                        ),
                      );
                    },
                  ),
                ),
                // Botão para adicionar alimento
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CoresApp.verdePrincipal,
                            foregroundColor: Colors.black,
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar alimento'),
                          onPressed: () async {
                            final alimento = await showModalBottomSheet<Map<String, dynamic>>(
                              context: context,
                              backgroundColor: CoresApp.cinzaEscuro,
                              builder: (context) {
                                return ListView(
                                  children: [
                                    ...alimentosDisponiveis.map((a) {
                                      return ListTile(
                                        title: Text(a['nome'], style: const TextStyle(color: Colors.white)),
                                        subtitle: Text(
                                          'P: ${a['proteina']}g | C: ${a['carbo']}g | G: ${a['gordura']}g',
                                          style: const TextStyle(color: Colors.white70),
                                        ),
                                        onTap: () async {
                                          Navigator.pop(context, a);
                                        },
                                      );
                                    }).toList(),
                                    ListTile(
                                      leading: const Icon(Icons.add, color: Colors.greenAccent),
                                      title: const Text('Adicionar novo alimento', style: TextStyle(color: Colors.greenAccent)),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final novo = await showDialog<Map<String, dynamic>>(
                                          context: context,
                                          builder: (context) {
                                            final nomeController = TextEditingController();
                                            final proController = TextEditingController();
                                            final carController = TextEditingController();
                                            final gorController = TextEditingController();
                                            return AlertDialog(
                                              backgroundColor: CoresApp.cinzaEscuro,
                                              title: const Text('Novo alimento', style: TextStyle(color: Colors.white)),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller: nomeController,
                                                    decoration: const InputDecoration(labelText: 'Nome', labelStyle: TextStyle(color: Colors.white70)),
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                  TextField(
                                                    controller: proController,
                                                    decoration: const InputDecoration(labelText: 'Proteína (g)', labelStyle: TextStyle(color: Colors.white70)),
                                                    keyboardType: TextInputType.number,
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                  TextField(
                                                    controller: carController,
                                                    decoration: const InputDecoration(labelText: 'Carboidrato (g)', labelStyle: TextStyle(color: Colors.white70)),
                                                    keyboardType: TextInputType.number,
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                  TextField(
                                                    controller: gorController,
                                                    decoration: const InputDecoration(labelText: 'Gordura (g)', labelStyle: TextStyle(color: Colors.white70)),
                                                    keyboardType: TextInputType.number,
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
                                                    if (nomeController.text.isNotEmpty &&
                                                        proController.text.isNotEmpty &&
                                                        carController.text.isNotEmpty &&
                                                        gorController.text.isNotEmpty) {
                                                      Navigator.pop(context, {
                                                        'nome': nomeController.text,
                                                        'proteina': int.tryParse(proController.text) ?? 0,
                                                        'carbo': int.tryParse(carController.text) ?? 0,
                                                        'gordura': int.tryParse(gorController.text) ?? 0,
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
                                          final quantidade = await showDialog<String>(
                                            context: context,
                                            builder: (context) {
                                              final controller = TextEditingController();
                                              return AlertDialog(
                                                backgroundColor: CoresApp.cinzaEscuro,
                                                title: const Text('Quantidade', style: TextStyle(color: Colors.white)),
                                                content: TextField(
                                                  controller: controller,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Quantidade (ex: 2 fatias, 100g, 1 copo)',
                                                    labelStyle: TextStyle(color: Colors.white70),
                                                  ),
                                                  style: const TextStyle(color: Colors.white),
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
                                                      Navigator.pop(context, controller.text);
                                                    },
                                                    child: const Text('Adicionar'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          adicionarAlimento(refeicoes[refeicaoSelecionada], novo, quantidade: quantidade ?? '');
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            if (alimento != null) {
                              final quantidade = await showDialog<String>(
                                context: context,
                                builder: (context) {
                                  final controller = TextEditingController();
                                  return AlertDialog(
                                    backgroundColor: CoresApp.cinzaEscuro,
                                    title: const Text('Quantidade', style: TextStyle(color: Colors.white)),
                                    content: TextField(
                                      controller: controller,
                                      decoration: const InputDecoration(
                                        labelText: 'Quantidade (ex: 2 fatias, 100g, 1 copo)',
                                        labelStyle: TextStyle(color: Colors.white70),
                                      ),
                                      style: const TextStyle(color: Colors.white),
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
                                          Navigator.pop(context, controller.text);
                                        },
                                        child: const Text('Adicionar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              adicionarAlimento(refeicoes[refeicaoSelecionada], alimento, quantidade: quantidade ?? '');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Resumo dos macros do dia
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    color: CoresApp.cinzaEscuro,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Proteína: ${macrosDia['proteina']}g', style: const TextStyle(color: Colors.white)),
                          Text('Carbo: ${macrosDia['carbo']}g', style: const TextStyle(color: Colors.white)),
                          Text('Gordura: ${macrosDia['gordura']}g', style: const TextStyle(color: Colors.white)),
                        ],
                      ),
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

