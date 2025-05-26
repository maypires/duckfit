import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../widgets/barra_inferior.dart';

class TelaConfig extends StatefulWidget {
  final Function(int)? onTabSelected;
  final int indiceAtual;
  const TelaConfig({super.key, this.onTabSelected, this.indiceAtual = 4});

  @override
  State<TelaConfig> createState() => _TelaConfigState();
}

class _TelaConfigState extends State<TelaConfig> {
  String nome = 'Chris Bumstead';
  String email = 'chris.bumstead@email.com';
  double peso = 102;
  double altura = 1.85;

  void _editarPerfil() async {
    final nomeCtrl = TextEditingController(text: nome);
    final emailCtrl = TextEditingController(text: email);
    final pesoCtrl = TextEditingController(text: peso.toString());
    final alturaCtrl = TextEditingController(text: altura.toString());

    final resultado = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: CoresApp.cinzaEscuro,
          title: const Text('Editar Perfil', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeCtrl,
                  decoration: const InputDecoration(labelText: 'Nome', labelStyle: TextStyle(color: Colors.white70)),
                  style: const TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.white70)),
                  style: const TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: pesoCtrl,
                  decoration: const InputDecoration(labelText: 'Peso (kg)', labelStyle: TextStyle(color: Colors.white70)),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: alturaCtrl,
                  decoration: const InputDecoration(labelText: 'Altura (m)', labelStyle: TextStyle(color: Colors.white70)),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
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
                  'nome': nomeCtrl.text,
                  'email': emailCtrl.text,
                  'peso': double.tryParse(pesoCtrl.text) ?? peso,
                  'altura': double.tryParse(alturaCtrl.text) ?? altura,
                });
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (resultado != null) {
      setState(() {
        nome = resultado['nome'];
        email = resultado['email'];
        peso = resultado['peso'];
        altura = resultado['altura'];
      });
    }
  }

  bool notificacoes = true;
  bool temaEscuro = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: CoresApp.verdePrincipal,
      ),
      backgroundColor: CoresApp.fundo,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Resumo do perfil
          Card(
            color: CoresApp.cinzaEscuro,
            margin: const EdgeInsets.only(bottom: 24),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/perfil.jpg'),
                    radius: 36,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nome, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(email, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 8),
                        Text('Peso: ${peso.toStringAsFixed(1)} kg', style: const TextStyle(color: Colors.white, fontSize: 15)),
                        Text('Altura: ${altura.toStringAsFixed(2)} m', style: const TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: CoresApp.verdePrincipal),
                    onPressed: _editarPerfil,
                    tooltip: 'Editar perfil',
                  ),
                ],
              ),
            ),
          ),
          const Text('Preferências', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          SwitchListTile(
            value: notificacoes,
            onChanged: (v) => setState(() => notificacoes = v),
            title: const Text('Receber notificações', style: TextStyle(color: Colors.white)),
            activeColor: CoresApp.verdePrincipal,
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile(
            value: temaEscuro,
            onChanged: (v) => setState(() => temaEscuro = v),
            title: const Text('Tema escuro', style: TextStyle(color: Colors.white)),
            activeColor: CoresApp.verdePrincipal,
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 24),
          const Text('Sobre', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Versão', style: TextStyle(color: Colors.white70)),
            trailing: Text('1.0.0', style: TextStyle(color: Colors.white)),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Desenvolvido por DuckFit', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
      bottomNavigationBar: BarraInferior(
        onTabSelected: (index) {
          if (widget.onTabSelected != null) {
            widget.onTabSelected!(index);
          }
        },
        currentIndex: widget.indiceAtual,
      ),
    );
  }
}
