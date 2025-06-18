import 'package:url_launcher/url_launcher.dart';

class SuporteController {
  void enviarEmailDeSuporte() async {
    final Uri emailUri = Uri(
      scheme: "mailto",
      path: "profmate.comercial@gmail.com",
      query: _encodeQueryParameters({
        'subject': "Dúvida sobre o app ProfMate",
        'body': "Olá, preciso de ajuda com...",
      }),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Não foi possível abrir o app de e-mail');
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}
