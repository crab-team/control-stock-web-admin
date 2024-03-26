import 'package:control_stock_web_admin/data/responses/commerce_response.dart';

abstract class CommerceRemoteDataSource {
  Future<CommerceResponse> getById(String id);
  Future<void> updateCashPaymenetPercentage(double cashPaymentPercentage);
}
