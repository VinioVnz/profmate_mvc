import 'package:flutter/material.dart';
import 'package:profmate/src/controller/configuracoes_controller.dart';

class ConfiguracoesView extends StatefulWidget {
  final ConfiguracoesController configuracoesController;
  const ConfiguracoesView({required this.configuracoesController, super.key});

  @override
  State<ConfiguracoesView> createState() => _ConfiguracoesViewState();
}

class _ConfiguracoesViewState extends State<ConfiguracoesView> {
  @override
  void initState() {
    super.initState();
    widget.configuracoesController.addListener(_atualizarView);
  }

  @override
  void dispose() {
    widget.configuracoesController.removeListener(_atualizarView);
    super.dispose();
  }

  void _atualizarView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final foto = widget.configuracoesController.imagemDePerfil;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: foto != null ? FileImage(foto) : null,
              child: foto == null ? Icon(Icons.person, size: 60) : null,
            ),
            TextButton(
              onPressed: () {
                widget.configuracoesController.selecionarImagem();
              },
              child: Text("Alterar foto"),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1.0, color: Color(0xffE6E6E6)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1.0, color: Color(0xffE6E6E6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Meus dados", style: TextStyle(fontSize: 16)),
                        Icon(
                          Icons.chevron_right,
                          size: 24,
                          color: Color.fromARGB(220, 151, 150, 150),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1.0, color: Color(0xffE6E6E6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Alterar senha", style: TextStyle(fontSize: 16)),
                        Icon(
                          Icons.chevron_right,
                          size: 24,
                          color: Color.fromARGB(220, 151, 150, 150),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1.0, color: Color(0xffE6E6E6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ativar notificações",
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(value: false, onChanged: (_) {}),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1.0, color: Color(0xffE6E6E6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Modo escuro", style: TextStyle(fontSize: 16)),
                        Switch(value: false, onChanged: (_) {}),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1.0, color: Color(0xffE6E6E6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cancelar assinatura",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 24,
                          color: Color.fromARGB(220, 151, 150, 150),
                        ),
                      ],
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
}
