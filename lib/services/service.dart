import 'dart:convert';
import 'dart:developer';
import 'package:boko_test/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

Future<String?> exchangeCodeForToken(String code, String codeVerifier) async {
  final Uri tokenUrl = Uri.parse(
      'https://sso.bitkap.africa/realms/bitkap_dev/protocol/openid-connect/token');

  try {
    // Envoi de la requête à l'endpoint du token
    final response = await http.post(
      tokenUrl,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUrl.toString(),
        'client_id': clientId,
        'code_verifier': codeVerifier,
        // 'client_secret': 'your_client_secret', // Si nécessaire
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> tokenData = jsonDecode(response.body);

      // Récupérer le token d'accès
      String? accessToken = tokenData['access_token'];

      if (accessToken != null) {
        // Décoder le JWT pour récupérer les informations utilisateur
        Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
        String username = payload['preferred_username'] ?? 'Unknown User';

        log('Access Token: $accessToken');
        log('Username: $username');
        return username;
      }
    } else {
      print('Erreur lors de la récupération du token: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Erreur lors de la requête du token: $e');
    return null;
  }
}
