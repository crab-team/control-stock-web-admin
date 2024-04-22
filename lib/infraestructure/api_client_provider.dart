import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<APIClient>((ref) {
  return APIClient(
      baseUrl: kDebugMode
          ? "http://127.0.0.1:5001/control-stock-2e370/us-central1/dev/"
          : "https://us-central1-control-stock-2e370.cloudfunctions.net/api");
});
