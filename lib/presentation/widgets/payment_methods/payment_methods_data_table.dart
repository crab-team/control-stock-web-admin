import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/presentation/providers/customers/customers_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/payment_methods/payment_methods_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/payment_methods/payment_methods_data_table_source.dart';
import 'package:control_stock_web_admin/presentation/widgets/payment_methods/payment_methods_drawer.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersDataTable extends ConsumerStatefulWidget {
  const CustomersDataTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomersDataTableState();
}

class _CustomersDataTableState extends ConsumerState<CustomersDataTable> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paymentMethodsControllerProvider);

    return state.when(
      data: (data) {
        return _buildDataTable(data);
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
    );
  }

  _buildDataTable(List<PaymentMethod> data) {
    return PaginatedDataTable2(
      border: dataTableDecoration['border'] as TableBorder,
      minWidth: dataTableDecoration['minWidth'] as double,
      rowsPerPage: dataTableDecoration['rowsPerPage'] as int,
      wrapInCard: dataTableDecoration['wrapInCard'] as bool,
      headingRowHeight: dataTableDecoration['headingRowHeight'] as double,
      dataRowHeight: dataTableDecoration['dataRowHeight'] as double,
      headingRowColor: dataTableDecoration['headingRowColor'] as MaterialStateProperty<Color>,
      actions: [
        const VerticalDivider(indent: 8, endIndent: 8),
        SearchBar(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const LinearBorder(),
          ),
          leading: const Icon(PhosphorIcons.magnifying_glass),
          hintText: Texts.searchCustomer,
          onChanged: (value) => _search(value),
        ),
        const VerticalDivider(indent: 8, endIndent: 8),
        const Gap.medium(isHorizontal: true),
        _buildAdd(),
      ],
      header: Text(
        Texts.customers,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      empty: const Center(child: Text(Texts.noCustomer)),
      columns: const [
        DataColumn2(
          label: Text(Texts.name),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(Texts.installments),
          size: ColumnSize.S,
        ),
        DataColumn2(
          fixedWidth: 300,
          label: Text(Texts.surchargePercentage),
          size: ColumnSize.S,
        ),
        DataColumn2(
          fixedWidth: 300,
          label: Text('Acciones'),
          size: ColumnSize.S,
        ),
      ],
      source: PaymentMethodsDataTableSource(
        data: data,
        onDelete: _delete,
        onEdit: (paymentMethod) => _openDrawer(context, paymentMethod),
      ),
    );
  }

  void _search(String value) {
    ref.read(customersControllerProvider.notifier).search(value);
  }

  void _delete(int id) {
    ref.read(customersControllerProvider.notifier).delete(id);
  }

  Widget _buildAdd() {
    return ElevatedButton.icon(
      icon: const Icon(PhosphorIcons.plus),
      onPressed: () => _openDrawer(context, null),
      label: const Text(Texts.addCustomer),
    );
  }

  _openDrawer(BuildContext context, PaymentMethod? paymentMethod) {
    ref.read(drawerController.notifier).state = PaymentMethodsDrawer(paymentMethod: paymentMethod);
  }
}
