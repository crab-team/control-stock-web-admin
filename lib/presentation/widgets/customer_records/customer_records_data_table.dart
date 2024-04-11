// import 'package:control_stock_web_admin/core/theme.dart';
// import 'package:control_stock_web_admin/domain/entities/customer.dart';
// import 'package:control_stock_web_admin/domain/entities/purchase.dart';
// import 'package:control_stock_web_admin/presentation/providers/customers/customer_records_controller.dart';
// import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
// import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
// import 'package:control_stock_web_admin/presentation/utils/constants.dart';
// import 'package:control_stock_web_admin/presentation/widgets/customer_records/customer_records_data_table_source.dart';
// import 'package:control_stock_web_admin/presentation/widgets/customers/customer_drawer.dart';
// import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
// import 'package:currency_formatter/currency_formatter.dart';
// import 'package:data_table_2/data_table_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class CustomerRecordsDataTable extends ConsumerStatefulWidget {
//   final Customer customer;
//   const CustomerRecordsDataTable({super.key, required this.customer});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CustomersDataTableState();
// }

// class _CustomersDataTableState extends ConsumerState<CustomerRecordsDataTable> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(customerRecordsControllerProvider.notifier).getAllCustomerRecords(widget.customer.id!);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(customerRecordsControllerProvider);

//     return state.when(
//       data: (data) {
//         return _buildDataTable(data);
//       },
//       loading: () {
//         return const Center(child: CircularProgressIndicator());
//       },
//       error: (error, stackTrace) {
//         return Center(child: Text('Error: $error'));
//       },
//     );
//   }

//   _buildDataTable(List<Purchase> data) {
//     double debt = getTotalDebt(data);

//     return PaginatedDataTable2(
//       border: dataTableDecoration['border'] as TableBorder,
//       minWidth: dataTableDecoration['minWidth'] as double,
//       rowsPerPage: dataTableDecoration['rowsPerPage'] as int,
//       wrapInCard: dataTableDecoration['wrapInCard'] as bool,
//       headingRowHeight: dataTableDecoration['headingRowHeight'] as double,
//       dataRowHeight: dataTableDecoration['dataRowHeight'] as double,
//       headingRowColor: dataTableDecoration['headingRowColor'] as MaterialStateProperty<Color>,
//       actions: [
//         const VerticalDivider(indent: 8, endIndent: 8),
//         SearchBar(
//           shape: MaterialStateProperty.all<OutlinedBorder>(const LinearBorder()),
//           leading: const Icon(PhosphorIcons.magnifying_glass),
//           hintText: Texts.searchRecord,
//           onChanged: (value) => _search(value),
//         ),
//         const VerticalDivider(indent: 8, endIndent: 8),
//         const Gap.medium(isHorizontal: true),
//         _buildAddRecord(),
//       ],
//       header: _buildHeader(debt),
//       empty: const Center(child: Text(Texts.noRecords)),
//       columns: const [
//         DataColumn2(
//           label: Text(Texts.code),
//           size: ColumnSize.S,
//         ),
//         DataColumn2(
//           fixedWidth: 300,
//           label: Text(Texts.productName),
//           size: ColumnSize.L,
//         ),
//         DataColumn2(
//           label: Text(Texts.unitPrice),
//           size: ColumnSize.S,
//         ),
//         DataColumn2(
//           label: Text(Texts.quantity),
//           size: ColumnSize.S,
//         ),
//         DataColumn2(
//           label: Text(Texts.total),
//           size: ColumnSize.M,
//         ),
//         DataColumn2(
//           label: Text(Texts.paymentStatus),
//           size: ColumnSize.M,
//         ),
//         DataColumn2(
//           label: Text(Texts.paymentMethod),
//           size: ColumnSize.M,
//         ),
//         DataColumn2(
//           label: Text(Texts.surcharge),
//           size: ColumnSize.S,
//         ),
//         DataColumn2(
//           fixedWidth: 150,
//           label: Text('Acciones'),
//           size: ColumnSize.S,
//         ),
//       ],
//       source: CustomerRecordsDataTableSource(data: data, onDelete: _delete),
//     );
//   }

//   Widget _buildHeader(double debt) {
//     return Row(
//       children: [
//         Text(
//           widget.customer.fullName,
//           style: Theme.of(context).textTheme.headlineSmall,
//         ),
//         const Spacer(),
//         const VerticalDivider(indent: 8, endIndent: 8),
//         const Gap.small(isHorizontal: true),
//         Text('${Texts.debt} ${CurrencyFormatter.format(debt, arsSettings)}',
//             style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: colorScheme.tertiary)),
//         const Spacer(),
//       ],
//     );
//   }

//   void _search(String value) {
//     ref.read(customerRecordsControllerProvider.notifier).search(value);
//   }

//   void _delete(int id) {
//     ref.read(customersControllerProvider.notifier).delete(id);
//   }

//   Widget _buildAddRecord() {
//     return ElevatedButton.icon(
//       icon: const Icon(PhosphorIcons.plus),
//       onPressed: () => _openDrawer(context, ref),
//       label: const Text(Texts.addRecord),
//     );
//   }

//   _openDrawer(BuildContext context, WidgetRef ref) {
//     ref.read(drawerController.notifier).state = const CustomerDrawer();
//   }

//   double getTotalDebt(List<Purchase> data) {
//     double total = 0;
//     for (var record in data) {
//       if (record.paymentStatus == PaymentStatus.pending) {
//         total += record.unitPrice * record.quantity;
//       }
//     }
//     return total;
//   }
// }
