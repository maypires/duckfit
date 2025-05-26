import 'package:flutter/material.dart';
import '../theme/cores_app.dart';
import '../widgets/botao_degrade.dart';
import '../widgets/barra_superior.dart';
import '../widgets/barra_inferior.dart';
import '../widgets/card_com_botao.dart';
import '../widgets/barra_lateral.dart';
import 'tela_treino_personal.dart';
import 'tela_treino_duck.dart';

class TelaTreino extends StatelessWidget {
  final VoidCallback onDuckTap;
  final VoidCallback onPersonalTap;
  final VoidCallback onMonteTap;
  final int indiceAtual;
  final Function(int) onTabSelected;
  final VoidCallback? onLogout;

  const TelaTreino({
    super.key,
    required this.onDuckTap,
    required this.onPersonalTap,
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
              titulo: 'TREINO DUCK',
              descricao: 'Treino padrão desenvolvido pela equipe DuckFit para todos os perfis.',
              imagem: 'assets/treino1.jpeg',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TelaTreinoDuck()),
                );
              },
            ),
            CardComBotao(
              titulo: 'PERSONAL',
              descricao: 'Treino personalizado criado pelo seu personal trainer.',
              imagem: 'assets/treino2.jpeg',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TelaTreinoPersonal()),
                );
              },
            ),
            CardComBotao(
              titulo: 'MONTE SEU TREINO',
              descricao: 'Monte seu próprio treino de acordo com suas preferências e objetivos.',
              imagem: 'assets/treino.jpg',
              onPressed: () {
                Navigator.of(context).pushNamed('/telaTreinoMonte');
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

