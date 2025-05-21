import 'package:flutter/material.dart';
import '../theme/cores_app.dart';

class BarraInferior extends StatelessWidget {
  final Function(int) onTabSelected;
  final int currentIndex;
  const BarraInferior({super.key, required this.onTabSelected, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    Color destaque = Colors.white;
    Color corHome = CoresApp.cinzaEscuro;
    Color corSelecionado = const Color(0xFF00875A); // verde mais escuro
    double tamanhoIcone = 32;
    double tamanhoIconeHome = 40;

    Widget buildIcon(int index, IconData icon, {bool isHome = false}) {
      bool selecionado = currentIndex == index;
      double size = isHome ? tamanhoIconeHome : tamanhoIcone;
      return GestureDetector(
        onTap: () => onTabSelected(index),
        child: Container(
          width: 69,
          height: 69,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: selecionado
                ? (isHome ? destaque : corSelecionado)
                : Colors.transparent,
            boxShadow: selecionado && isHome
                ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: Icon(
            icon,
            size: size,
            color: selecionado
                ? (isHome ? Colors.black : Colors.white)
                : Colors.white,
          ),
        ),
      );
    }

    return Container(
      height: 69,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CoresApp.verdePrincipal,
            CoresApp.verdePrincipal,
            CoresApp.verdeAgua,
          ],
          stops: [0.0, 0.7, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildIcon(0, Icons.restaurant_menu),
              buildIcon(1, Icons.fitness_center),
              buildIcon(2, Icons.home, isHome: true),
              buildIcon(3, Icons.assignment),
              buildIcon(4, Icons.settings),
            ],
          ),
        ),
      ),
    );
  }
}
