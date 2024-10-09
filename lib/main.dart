import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:boko_test/home.dart';
import 'package:boko_test/services/service.dart';
import 'package:boko_test/utils/color.dart';
import 'package:boko_test/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:math' as math;
import 'package:crypto/crypto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAuthenticated = false;
  String? accessToken;
  String? username;
  var codeVerifierSave;
  bool load = false;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  oauth2.AuthorizationCodeGrant? grant;
  @override
  void initState() {
    super.initState();
    initDeepLinks();
    // _handleIncomingLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  String generateCodeVerifier() {
    final math.Random random = math.Random.secure();
    final List<int> values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values).replaceAll('=', '');
  }

// Génération d'un code_challenge à partir du code_verifier
  String generateCodeChallenge(String codeVerifier) {
    var bytes =
        utf8.encode(codeVerifier); // convertir le code_verifier en octets
    var digest = sha256.convert(bytes); // SHA256 hash
    return base64Url.encode(digest.bytes).replaceAll('=', '');
  }

  Future<void> authenticate() async {
    try {
      String codeVerifier = generateCodeVerifier();
      String codeChallenge = generateCodeChallenge(codeVerifier);
      grant = oauth2.AuthorizationCodeGrant(
        clientId,
        authorizationEndpoint,
        tokenEndpoint,
      );
      codeVerifierSave = codeVerifier;
      // var authorizationUrl = Uri.parse(
      //     'https://sso.bitkap.africa/realms/bitkap_dev/protocol/openid-connect/auth?response_type=code&client_id=angolar_test&redirect_uri=https%3A%2F%2Fsso.bitkap.africa%2Foauth2%2Fcallback&code_challenge=7odYwvfZYs7oZtk6oV6llSTw_zOyOfHdY_RbrDq2C-k&code_challenge_method=S256'); // var authorizationUrl = Uri.parse('https://www.google.com');
      // grant!.getAuthorizationUrl(
      var authorizationUrl = Uri.parse('$authorizationEndpoint'
          '?response_type=code'
          '&client_id=$clientId'
          '&redirect_uri=${Uri.encodeComponent(redirectUrl.toString())}'
          '&code_challenge=$codeChallenge'
          '&code_challenge_method=S256');
      // );

      if (await canLaunchUrl(authorizationUrl)) {
        await launchUrl(
          authorizationUrl,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $authorizationUrl';
      }
    } catch (e) {
      print('Error during authentication: $e');
    }
  }

  Future<void> initDeepLinks() async {
    try {
      _appLinks = AppLinks();

      // Handle links
      _linkSubscription = _appLinks.uriLinkStream.listen((uri) async {
        debugPrint('onAppLink: $uri');
        log('onAppLink: $uri');
        // Récupérer le code d'autorisation de l'URL de redirection
        String? code = uri.queryParameters['code'];

        if (code != null) {
          // Échanger le code contre un token
          setState(() {
            load = true;
          });
          var result = await exchangeCodeForToken(code, codeVerifierSave);

          if (result != null) {
            setState(() {
              username = result;
              isAuthenticated = true;
            });
          }
          setState(() {
            load = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: isAuthenticated
            ? HomePage(
                user_name: username ?? "UserName",
              )
            : load
                ? Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        color: gray2Color,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Loading ...",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: authenticate,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Login with Keycloak",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
