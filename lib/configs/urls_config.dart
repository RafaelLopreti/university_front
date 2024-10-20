class UrlsConfig {
  static const String baseUrl = 'http://10.0.0.225';
  static const int port = 8080;
  static const String path = '/api/v1/university';
  
  static const String loginEndpoint = '/login';
  static const String usersEndpoint = '/users';
  static const String userEmailEndpoint = '/users-email/';
  
  static const String loginUrl = '$baseUrl:$port$path$loginEndpoint';
  static const String registerUrl = '$baseUrl:$port$path$usersEndpoint';
  static const String userByEmailUrl = '$baseUrl:$port$path$userEmailEndpoint';
}
