import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/cores_app.dart';
import '../widgets/botao_degrade.dart';
import 'tela_home.dart';

class TelaLogin extends StatefulWidget {
  final VoidCallback? onLogin;
  const TelaLogin({super.key, this.onLogin});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  bool isPersonal = false;
  bool modoCadastro = false;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  Future<void> fazerLoginOuCadastro() async {
    final nome = nomeController.text.trim();
    final senha = senhaController.text.trim();

    if (modoCadastro) {
      _mostrarMensagem("Aluno cadastrado com sucesso!\nNome: $nome");
      setState(() => modoCadastro = false);
      return;
    }

    if (widget.onLogin != null) {
      widget.onLogin!();
    }
  }

  void _mostrarMensagem(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: CoresApp.cinzaEscuro,
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            child: const Text("OK", style: TextStyle(color: CoresApp.verdePrincipal)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final alunoTheme = !isPersonal;

    return Scaffold(
      backgroundColor: CoresApp.fundo,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Image.asset(
                'assets/duck.png',
                height: 150,
              ),
            ),
            Container(
              width: 360,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: CoresApp.cinzaEscuro,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Alternância de usuário
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _iconeUsuario(Icons.person, "Aluno"),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPersonal = !isPersonal;
                            modoCadastro = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 80,
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: alunoTheme ? CoresApp.verdePrincipal : Colors.blue,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 300),
                                left: isPersonal ? 50 : 2,
                                top: 1,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.black26, blurRadius: 4),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _iconeUsuario(Icons.person_outline, "Personal"),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    modoCadastro
                        ? "Cadastro Aluno"
                        : isPersonal
                        ? "Login Personal"
                        : "Login Aluno",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  _campoTexto(nomeController, isPersonal ? "Nome do Personal" : "Nome do Aluno"),
                  const SizedBox(height: 15),
                  _campoTexto(senhaController, isPersonal ? "Senha do Personal" : "Senha do Aluno", senha: true),
                  const SizedBox(height: 25),
                  BotaoDegrade(
                    label: modoCadastro
                        ? "Cadastrar"
                        : isPersonal
                        ? "Entrar como Personal"
                        : "Entrar como Aluno",
                    onPressed: fazerLoginOuCadastro,
                  ),
                  const SizedBox(height:5),
                  if (!isPersonal)
                    TextButton(
                      onPressed: () => setState(() => modoCadastro = !modoCadastro),
                      child: Text(
                        modoCadastro ? "Voltar para Login" : "Cadastrar Aluno",
                        style: GoogleFonts.poppins(color: Colors.white54),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoTexto(TextEditingController controller, String texto, {bool senha = false}) {
    return TextField(
      controller: controller,
      obscureText: senha,
      style: GoogleFonts.poppins(color: Colors.white),
      decoration: InputDecoration(
        hintText: texto,
        hintStyle: GoogleFonts.poppins(color: Colors.white54),
        filled: true,
        fillColor: CoresApp.fundo.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  Column _iconeUsuario(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.white),
        Text(label, style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
