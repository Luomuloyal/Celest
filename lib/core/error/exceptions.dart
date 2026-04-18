class ServerException implements Exception {
  const ServerException([this.message = 'Server exception']);

  final String message;
}
