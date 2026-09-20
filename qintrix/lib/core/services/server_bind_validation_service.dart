import 'dart:io';

class ServerBindValidationResult {
  const ServerBindValidationResult({
    required this.isValid,
    this.message,
  });

  final bool isValid;
  final String? message;
}

class ServerBindValidationService {
  const ServerBindValidationService();

  Future<ServerBindValidationResult> validate({
    required String host,
    required int port,
  }) async {
    HttpServer? server;
    try {
      server = await HttpServer.bind(host, port);
      return const ServerBindValidationResult(isValid: true);
    } on SocketException catch (error) {
      return ServerBindValidationResult(
        isValid: false,
        message: error.message.isEmpty ? error.toString() : error.message,
      );
    } catch (error) {
      return ServerBindValidationResult(
        isValid: false,
        message: error.toString(),
      );
    } finally {
      await server?.close(force: true);
    }
  }
}
