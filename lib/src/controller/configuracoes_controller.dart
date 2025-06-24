import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ConfiguracoesController extends ChangeNotifier {
  File? _imagemDePerfil;
  final ImagePicker _selecionarImagens = ImagePicker();

  File? get imagemDePerfil => _imagemDePerfil;

  Future<void> selecionarImagem() async {
    final XFile? imagemSelecionada = await _selecionarImagens.pickImage(source: ImageSource.gallery);

    if (imagemSelecionada != null) {
      _imagemDePerfil = File(imagemSelecionada.path);
      notifyListeners();  
    }
  }
}