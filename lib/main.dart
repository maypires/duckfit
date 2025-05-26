import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/tela_login.dart';
import 'screens/tela_home.dart';
import 'screens/tela_dieta.dart';
import 'screens/tela_treino.dart';
import 'theme/cores_app.dart';
import 'screens/tela_anotações.dart';
import 'screens/tela_dieta_nutri.dart';
import 'screens/tela_treino_personal.dart';
import 'screens/tela_treino_monte.dart';
import 'screens/config.dart';

void main() {
  runApp(const DuckFitApp());
}

class DuckFitApp extends StatefulWidget {
  const DuckFitApp({super.key});

  @override
  State<DuckFitApp> createState() => _DuckFitAppState();
}

class _DuckFitAppState extends State<DuckFitApp> {
  bool _logado = false;
  int _indiceAtual = 2; // 2 = Home

  void _onTabSelected(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  void _onLogin() {
    setState(() {
      _logado = true;
      _indiceAtual = 2;
    });
  }

  void _onLogout() {
    setState(() {
      _logado = false;
      _indiceAtual = 2;
    });
  }

  void _onCardTap(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? tela;
    if (!_logado) {
      tela = TelaLogin(onLogin: _onLogin);
    } else {
      switch (_indiceAtual) {
        case 0:
          tela = TelaDieta(
            onNutriTap: () {
            },
            onMonteTap: () {},
            indiceAtual: _indiceAtual,
            onTabSelected: _onTabSelected,
            onLogout: _onLogout,
          );
          break;
        case 1:
          tela = TelaTreino(
            onDuckTap: () {},
            onPersonalTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const TelaTreinoPersonal()),
              );
            },
            onMonteTap: () {
              Navigator.of(context).pushNamed('/telaTreinoMonte');
            },
            indiceAtual: _indiceAtual,
            onTabSelected: _onTabSelected,
            onLogout: _onLogout,
          );
          break;
        case 2:
          tela = TelaHome(
            onCardTap: _onCardTap,
            indiceAtual: _indiceAtual,
            onTabSelected: _onTabSelected,
            onLogout: _onLogout,
          );
          break;
        case 3:
          tela = TelaAnotacoes(
            indiceAtual: _indiceAtual,
            onTabSelected: _onTabSelected,
            onLogout: _onLogout,
          );
          break;
        case 4:
          tela = TelaConfig(
            onTabSelected: _onTabSelected,
            indiceAtual: _indiceAtual,
          );
          break;
        default:
          tela = TelaHome(
            onCardTap: _onCardTap,
            indiceAtual: _indiceAtual,
            onTabSelected: _onTabSelected,
            onLogout: _onLogout,
          );
          break;
      }
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
      routes: {
        '/telaTreinoMonte': (_) => const TelaTreinoMonte(),
      },
    );
  }
}
