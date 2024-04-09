import 'package:control_stock_web_admin/data/responses/payment_method_response.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';

abstract class PaymentMethodsRemoteDataSource {
  Future<List<PaymentMethodResponse>> getAll();
  Future<void> update(PaymentMethod paymentMethod);
  Future<void> delete(String id);
  Future<PaymentMethodResponse> create(PaymentMethod paymentMethod);
}
