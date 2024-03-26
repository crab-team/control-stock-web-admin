import 'package:control_stock_web_admin/infraestructure/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<APIClient>((ref) {
  return APIClient(baseUrl: "http://127.0.0.1:5000");
});
