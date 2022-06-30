import 'dart:io';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [Interceptor()],
  requestTimeout: const Duration(seconds: 10),
);

Future<bool> checkConnection() async {
  try {
    final result = await InternetAddress.lookup('change');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
    return false;
  } on SocketException catch (_) {
    return false;
  }
}
