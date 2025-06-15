import 'package:flutter/material.dart';

class BulletinBoardView extends StatefulWidget {
  BulletinBoardView({super.key});

  @override
  State<BulletinBoardView> createState() => _BulletinBoardViewState();
}

class _BulletinBoardViewState extends State<BulletinBoardView> {
  final TextEditingController controller = TextEditingController();
  List<String> recados = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: recados.length,
              itemBuilder: (context, index) {
                final recado = recados[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Card(
                        color: const Color.fromARGB(255, 01, 11, 40),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recado,
                                style: TextStyle(fontSize: 16, color: Colors.white),
                                
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Escreva seu recado",
                      border: InputBorder.none
                    ),
                  )
                ),
                IconButton(
                  onPressed: () {
                    final texto = controller.text.trim();
                    if (texto.isNotEmpty) {
                      setState(() {
                        recados.add(texto);
                      });
                      controller.clear();
                    }
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
