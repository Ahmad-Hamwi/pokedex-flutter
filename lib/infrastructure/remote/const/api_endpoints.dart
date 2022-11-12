class ApiEndpoints {
  static const String baseUrl = "https://pokeapi.co/";
  static const String v2Route = "api/v2/";

  static const String apiBaseUrl = baseUrl + v2Route;

  static const String pokemon = "$apiBaseUrl/pokemon";
}

class ResponseCode {
  static const int success = 200;
  static const int serverException = 500;
}
