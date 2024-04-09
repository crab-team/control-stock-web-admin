import 'package:control_stock_web_admin/data/models/payment_method_model.dart';
import 'package:control_stock_web_admin/data/responses/payment_method_response.dart';

abstract class PaymentMethodsRemoteDataSource {
  Future<List<PaymentMethodResponse>> getAll();
  Future<void> update(PaymentMethodModel paymentMethod);
  Future<void> delete(int id);
  Future<PaymentMethodResponse> create(PaymentMethodModel paymentMethod);
}
