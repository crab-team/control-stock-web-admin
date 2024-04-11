import 'package:control_stock_web_admin/data/models/commerce_model.dart';
import 'package:control_stock_web_admin/data/responses/commerce_response.dart';

abstract class CommerceRemoteDataSource {
  Future<CommerceResponse> getById(String id);
  Future<void> update(CommerceModel commerce);
}
