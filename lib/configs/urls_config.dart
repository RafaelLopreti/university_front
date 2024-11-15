class UrlsConfig {
  static const String _baseIpServer = 'http://10.0.0.2';
  static const String _baseIpLocal = 'http://0.0.0.0';
  static const int port = 8080;
  static const String path = '/api/v1/university';

  static bool useLocal = true;

  static String get baseUrl => useLocal ? _baseIpLocal : _baseIpServer;

  static const String _loginEndpoint = '/login';
  static const String _usersEndpoint = '/users';
  static const String _userEmailEndpoint = '/users-email/';

  static String get loginUrl => _buildUrl(_loginEndpoint);
  static String get registerUrl => _buildUrl(_usersEndpoint);
  static String get userByEmailUrl => _buildUrl(_userEmailEndpoint);
  static String get userUrl => _buildUrl(_usersEndpoint);

  static String _buildUrl(String endpoint) => '$baseUrl:$port$path$endpoint';
}
