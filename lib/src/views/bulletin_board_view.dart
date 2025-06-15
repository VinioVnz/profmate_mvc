import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profmate/src/controller/bulletin_board_controller.dart';
import 'package:profmate/src/models/bulletin_board_model.dart';

class BulletinBoardView extends StatefulWidget {
  const BulletinBoardView({super.key, required this.controller});

  final BulletinBoardController controller;

  @override
  State<BulletinBoardView> createState() => _BulletinBoardViewState();
}

class _BulletinBoardViewState extends State<BulletinBoardView> {
  BulletinBoardController get controller => widget.controller;

  final TextEditingController noteController = TextEditingController();

  void alertConfirmarDelete(BulletinBoardModel recado) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Apagar recado"),
          content: Text("Deseja realmente apagar este recado?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                controller.deletarRecado(recado);
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void adicionaRecado() {
    final texto = noteController.text.trim();
    controller.adicionaRecado(texto);
    noteController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: controller.recados,
              builder: (context, recados, _) {
                if (recados.isEmpty) {
                  return Center(
                    child: Text(
                      'Não há recados no mural.',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: recados.length,
                  itemBuilder: (context, index) {
                    final recado = recados[index];
                    return Card(
                      color: const Color.fromARGB(255, 01, 11, 40),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          top: 8,
                          bottom: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      recado.texto,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () => alertConfirmarDelete(recado),
                                  icon: Icon(Icons.close, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(
                                DateFormat('dd/MM/y').format(recado.data),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: noteController,
                    decoration: InputDecoration(
                      hintText: "Escreva seu recado",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(onPressed: adicionaRecado, icon: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
