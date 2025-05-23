import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/tela_login.dart';
// import 'screens/tela_home.dart';
// import 'screens/tela_dieta.dart';
// import 'theme/cores_app.dart';

void main() {
  runApp(const DuckFitLoginApp());
}

class DuckFitLoginApp extends StatelessWidget {
  const DuckFitLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const TelaLogin(),
    );
  }
}

/*
// --- main antigo comentado ---
import 'screens/tela_home.dart';
import 'screens/tela_dieta.dart';
import 'theme/cores_app.dart';

class DuckFitApp extends StatefulWidget {
  const DuckFitApp({super.key});

  @override
  State<DuckFitApp> createState() => HomeScreenState();
}

class HomeScreenState extends State<DuckFitApp> {
  int _indiceAtual = 2; // Começa na home (índice 2)

  void onItemTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  void irParaDieta() {
    setState(() {
      _indiceAtual = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget tela;
    switch (_indiceAtual) {
      case 0:
        tela = TelaDieta(
          onNutriTap: () {},
          onMonteTap: () {},
          indiceAtual: _indiceAtual,
          onTabSelected: onItemTapped,
        );
        break;
      default:
        tela = TelaHome(
          onCardTap: (index) {
            if (index == 0) {
              irParaDieta();
            }
            // Se quiser tratar outros cards, adicione aqui
          },
          indiceAtual: _indiceAtual,
          onTabSelected: onItemTapped,
        );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CoresApp.fundo,
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: tela,
    );
  }
}
*/
