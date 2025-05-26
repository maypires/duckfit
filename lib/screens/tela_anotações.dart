import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../widgets/barra_superior.dart';
import '../widgets/barra_inferior.dart';
import '../widgets/barra_lateral.dart';

class TelaAnotacoes extends StatefulWidget {
  final int indiceAtual;
  final Function(int) onTabSelected;
  final VoidCallback? onLogout;

  const TelaAnotacoes({
    super.key,
    required this.indiceAtual,
    required this.onTabSelected,
    this.onLogout,
  });

  @override
  State<TelaAnotacoes> createState() => _TelaAnotacoesState();
}

class _TelaAnotacoesState extends State<TelaAnotacoes> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _anotacaoController = TextEditingController();

  // Mock de imagens da galeria
  final List<String> _imagens = [
    'assets/evolucao1.jpg',
    'assets/evolucao2.jpg',
    'assets/evolucao3.jpg',
    // Adicione mais imagens conforme desejar
  ];

  // Feed de anotações do aluno (sessão atual)
  final List<String> _feedAnotacoes = [];
  // Feed de anotações do personal (mock, somente leitura)
  final List<String> _feedPersonal = [
    // Exemplo de notas do personal
    "Lembre-se de alongar antes do treino.",
    "Ótimo progresso esta semana!",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _anotacaoController.dispose();
    super.dispose();
  }

  void _salvarAnotacao() {
    final texto = _anotacaoController.text.trim();
    if (texto.isNotEmpty) {
      setState(() {
        _feedAnotacoes.insert(0, texto);
        _anotacaoController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anotação salva!')),
      );
    }
  }

  void _atualizarPersonal() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notas do personal atualizadas!')),
    );
    // Aqui você pode implementar atualização real futuramente
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BarraSuperior(),
      ),
      endDrawer: BarraLateral(onLogout: widget.onLogout),
      backgroundColor: CoresApp.fundo,
      body: Column(
        children: [
          Container(
            color: CoresApp.cinzaEscuro,
            child: TabBar(
              controller: _tabController,
              labelColor: CoresApp.verdePrincipal,
              unselectedLabelColor: Colors.white70,
              indicatorColor: CoresApp.verdePrincipal,
              tabs: const [
                Tab(text: 'Minhas Anotações', icon: Icon(Icons.note)),
                Tab(text: 'Galeria', icon: Icon(Icons.photo_library)),
                Tab(text: 'Personal', icon: Icon(Icons.person)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Minhas Anotações
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextField(
                              controller: _anotacaoController,
                              maxLines: null,
                              minLines: 3,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Escreva suas anotações aqui...',
                                hintStyle: const TextStyle(color: Colors.white54),
                                filled: true,
                                fillColor: CoresApp.cinzaEscuro,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.save),
                              label: const Text('Salvar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CoresApp.verdePrincipal,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _salvarAnotacao,
                            ),
                            const SizedBox(height: 16),
                            if (_feedAnotacoes.isNotEmpty)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Minhas Anotações',
                                  style: TextStyle(
                                    color: CoresApp.verdePrincipal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            if (_feedAnotacoes.isNotEmpty)
                              const SizedBox(height: 8),
                            Expanded(
                              child: _feedAnotacoes.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'Nenhuma anotação salva.',
                                        style: TextStyle(color: Colors.white54),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: _feedAnotacoes.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: CoresApp.cinzaEscuro,
                                          margin: const EdgeInsets.only(bottom: 10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Text(
                                              _feedAnotacoes[index],
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Galeria
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    itemCount: _imagens.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          _imagens[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                // Anotações do Personal (somente leitura)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'As notas do seu personal aparecerão aqui',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _feedPersonal.isEmpty
                            ? const Center(
                                child: Text(
                                  'Nenhuma anotação do personal disponível.',
                                  style: TextStyle(color: Colors.white54),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _feedPersonal.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: CoresApp.cinzaEscuro,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        _feedPersonal[index],
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text('Atualizar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CoresApp.verdePrincipal,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _atualizarPersonal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarraInferior(
        onTabSelected: widget.onTabSelected,
        currentIndex: widget.indiceAtual,
      ),
    );
  }
}
