import 'package:flutter/material.dart';
import 'tela_home.dart';
import 'tela_dieta.dart';
import 'tela_treino.dart';
import 'dart:io';
import 'package:window_size/window_size.dart';

void main() {
  //Verifica se o aplicativo está rodando em um desktop e define o título e o tamanho da janela
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('DuckFit');
    setWindowMinSize(const Size(375, 812));
    setWindowMaxSize(const Size(375, 812));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    Definir o título do app
    Aplicar o tema global do app.
    Definir a tela inicial (home: const HomeScreen()), que será exibida ao abrir o app.
    */
    return MaterialApp(
      title: 'DuckFit',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  //Cria o estado inicial do widget HomeScreen,, o que significa que ele pode ter um estado mutável.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  //Define um índice selecionado (_selectedIndex) que controla qual página é exibida no aplicativo.
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      TelaHome(onCardTap: onItemTapped),
      TelaDieta(),
      TelaTreino(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    /*
    Constrói a tela principal do app com:
    - Gradiente de fundo (preto para cinza escuro) em toda a tela.
    - Scaffold transparente para sobrepor o conteúdo.
    - Barra de navegação inferior com gradiente verde-azulado, usando Stack para sobrepor o BottomNavigationBar.
    - Exibe a página selecionada conforme o índice.
    */
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF292929), Color(0xFF0E0E0E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Stack(
          children: [
            Container(
              height: 60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF01E47B), Color(0xFF05D3BE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(
                  icon: Icon(Icons.restaurant),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center),
                  label: '',
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Color(0xFFD0FFF3),
              unselectedItemColor: Color(0xFF1F3C36),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _selectedIndex,
              onTap: onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}
