class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, {this.statusCode});

  @override
  String toString() =>
      'ServerException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException({this.message = 'Request timed out'});

  @override
  String toString() => 'TimeoutException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}
