import 'package:flutter/material.dart';
import 'package:profmate/src/widgets/home_button.dart';

class ConfiguracoesView extends StatefulWidget {
  const ConfiguracoesView({super.key});

  @override
  State<ConfiguracoesView> createState() => _ConfiguracoesViewState();
}

class _ConfiguracoesViewState extends State<ConfiguracoesView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeButton(
                label: 'Meu perfil',
                onPressed: () {},
                icon: Icons.person,
              ),
              HomeButton(
                label: 'Alterar senha',
                onPressed: () {},
                icon: Icons.password,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeButton(
                label: "Notificações",
                onPressed: () {},
                icon: Icons.notifications,
              ),
              HomeButton(
                label: "Personalizar",
                onPressed: () {},
                icon: Icons.palette,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // Lógica para cancelar assinatura aqui
                  // Adicionar um alerta sobre o cancelamento para tentar convercer de não cancelar
                },
                child: Text(
                  "Cancelar assinatura",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
