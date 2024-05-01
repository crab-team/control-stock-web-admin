import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order.dart';
import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/orders/orders_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/purchases/purchase_drawer.dart';
import 'package:control_stock_web_admin/presentation/widgets/orders/orders_data_table_source.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersDataTable extends ConsumerStatefulWidget {
  const OrdersDataTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersDataTableState();
}

class _OrdersDataTableState extends ConsumerState<OrdersDataTable> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(ordersControllerProvider);
    return _buildDataTable(data);
  }

  _buildDataTable(List<PurchaseOrder> data) {
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
          hintText: Texts.searchOrder,
          onChanged: (value) => _search(value),
        ),
        const VerticalDivider(indent: 8, endIndent: 8),
        const Gap.medium(isHorizontal: true),
        _buildAddOrder(),
      ],
      header: Text(
        Texts.orders,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      empty: const Center(child: Text(Texts.noOrders)),
      columns: const [
        DataColumn2(
          fixedWidth: 100,
          label: Text(Texts.code),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(Texts.customer),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(Texts.products),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(Texts.quantityAbbreviation),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(Texts.price),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(Texts.debt),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(Texts.paymentMethod),
          size: ColumnSize.M,
        ),
        DataColumn2(
          fixedWidth: 300,
          label: Text(Texts.actions),
          size: ColumnSize.L,
        ),
      ],
      source: OrdersDataTableSource(data: data, onDelete: _delete),
    );
  }

  void _search(String value) {
    ref.read(ordersControllerProvider.notifier).search(value);
  }

  void _delete(int id) {
    ref.read(ordersControllerProvider.notifier).removeOrder(id);
  }

  Widget _buildAddOrder() {
    return ElevatedButton.icon(
      icon: const Icon(PhosphorIcons.plus),
      onPressed: () => _openDrawer(context, ref),
      label: const Text(Texts.addOrder),
    );
  }

  _openDrawer(BuildContext context, WidgetRef ref) {
    ref.read(drawerControllerProvider.notifier).state = const PurchaseDrawer();
  }
}
