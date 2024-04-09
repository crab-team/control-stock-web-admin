import 'package:control_stock_web_admin/domain/entities/customer_record.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerRecordsControllerProvider =
    AutoDisposeAsyncNotifierProvider<CustomerRecordsController, List<CustomerRecord>>(CustomerRecordsController.new);

class CustomerRecordsController extends AutoDisposeAsyncNotifier<List<CustomerRecord>> {
  @override
  build() {
    return [];
  }

  getAllCustomerRecords(int customerId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(getCustomerRecordsUseCaseProvider).execute(customerId);
      return response.fold(
        (l) => throw Exception('Error'),
        (r) => r,
      );
    });
  }
}
