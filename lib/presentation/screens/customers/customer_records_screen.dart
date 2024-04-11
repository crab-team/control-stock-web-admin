// import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
// import 'package:control_stock_web_admin/presentation/widgets/customer_records/customer_records_data_table.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class CustomerRecordsScreen extends ConsumerWidget {
//   final int customerId;

//   const CustomerRecordsScreen({super.key, required this.customerId});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(customersControllerProvider);
//     return state.when(
//       data: (data) {
//         final customer = data.firstWhere((element) => element.id == customerId);
//         return CustomerRecordsDataTable(customer: customer);
//       },
//       loading: () {
//         return const Center(child: CircularProgressIndicator());
//       },
//       error: (error, stackTrace) {
//         return Center(child: Text('Error: $error'));
//       },
//     );
//   }
// }
