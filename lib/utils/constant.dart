const String clientId = 'angolar_test';
final Uri redirectUrl = Uri.parse('https://sso.bitkap.africa/oauth2/callback');
const String issuer = 'https://sso.bitkap.africa/realms/bitkap_dev';
final authorizationEndpoint = Uri.parse(
    'https://sso.bitkap.africa/realms/bitkap_dev/protocol/openid-connect/auth');
final tokenEndpoint = Uri.parse(
    'https://sso.bitkap.africa/realms/bitkap_dev/protocol/openid-connect/token');
