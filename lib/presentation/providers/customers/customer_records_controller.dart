import 'package:control_stock_web_admin/domain/entities/customer_record.dart';
import 'package:control_stock_web_admin/providers/use_cases_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customerRecordsControllerProvider =
    AutoDisposeAsyncNotifierProvider<CustomerRecordsController, List<CustomerRecord>>(CustomerRecordsController.new);

class CustomerRecordsController extends AutoDisposeAsyncNotifier<List<CustomerRecord>> {
  List<CustomerRecord> records = [];
  @override
  build() {
    return records;
  }

  createRecords(int customerId, List<CustomerRecord> newRecords) async {
    records = [...records, ...newRecords];
    state = AsyncData(records);
    state = await AsyncValue.guard(() async {
      final response = await ref.read(createCustomerRecordsUseCaseProvider).execute(customerId, newRecords);
      return response.fold(
        (l) => throw Exception('Error'),
        (r) => r,
      );
    });
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

    records = state.asData!.value;
  }

  search(String query) {
    final currentRecords = state.asData!.value;

    if (query.isEmpty || query == '') {
      state = AsyncData(records);
      return;
    }

    state = AsyncData(currentRecords.where((element) {
      final byName = element.productName.toLowerCase().contains(query.toLowerCase());
      final byCode = element.productCode.toLowerCase().contains(query.toLowerCase());
      final byPaymentStatus = element.paymentStatus.label.toLowerCase().contains(query.toLowerCase());
      final byPaymentPayemntMethod = element.paymentMethodId.label.toLowerCase().contains(query.toLowerCase());
      return byName || byCode || byPaymentStatus || byPaymentPayemntMethod;
    }).toList());
  }
}
