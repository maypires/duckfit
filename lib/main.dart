import 'package:flutter/material.dart';
import 'screens/tela_home.dart';
import 'theme/cores_app.dart';

void main() {
  runApp(const DuckFitApp());
}

class DuckFitApp extends StatefulWidget {
  const DuckFitApp({super.key});

  @override
  State<DuckFitApp> createState() => HomeScreenState();
}

class HomeScreenState extends State<DuckFitApp> {

  int _indiceAtual = 0;

  void onItemTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final telas = [
      TelaHome(
        onCardTap: onItemTapped,
        indiceAtual: _indiceAtual,
        onTabSelected: onItemTapped,
      ),
      // Adicione outras telas conforme necessário, seguindo o mesmo padrão
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CoresApp.fundo,
      ),
      home: telas[0], // Sempre mostra a TelaHome, que agora gerencia navegação
    );
  }
}
