import 'package:control_stock_web_admin/data/repositories/auth_repository_implementation.dart';
import 'package:control_stock_web_admin/infraestructure/api_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepositoryImplementation(ref.read(apiClientProvider)));
