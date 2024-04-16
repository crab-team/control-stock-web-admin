import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';
import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/purchases/purchases_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/purchases/purchases_data_table_source.dart';
import 'package:control_stock_web_admin/presentation/widgets/purchases/purchases_drawer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchasesDataTable extends ConsumerStatefulWidget {
  const PurchasesDataTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DataTableState();
}

class _DataTableState extends ConsumerState<PurchasesDataTable> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(purchasesControllerProvider);

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

  _buildDataTable(List<Purchase> data) {
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
          shape: MaterialStateProperty.all<OutlinedBorder>(const LinearBorder()),
          leading: const Icon(PhosphorIcons.magnifying_glass),
          hintText: Texts.searchRecord,
          onChanged: (value) => _search(value),
        ),
      ],
      header: _buildHeader(),
      empty: const Center(child: Text(Texts.noRecords)),
      columns: const [
        DataColumn2(
          fixedWidth: 200,
          label: Text(Texts.customer),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(Texts.products),
          size: ColumnSize.L,
        ),
        DataColumn2(
          fixedWidth: 150,
          label: Text(Texts.total),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(Texts.purchaseStatus),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(Texts.createdAt),
          size: ColumnSize.S,
        ),
        DataColumn2(
          fixedWidth: 200,
          label: Text('Acciones'),
          size: ColumnSize.S,
        ),
      ],
      source: PurchasesDataTableSource(data: data, onEdit: _openDrawer, onCancel: _cancel),
    );
  }

  Widget _buildHeader() {
    return Text(
      Texts.purchases,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  void _openDrawer(Purchase purchase) {
    ref.read(drawerController.notifier).state = PurchasesDrawer(purchase: purchase);
  }

  void _search(String value) {
    ref.read(purchasesControllerProvider.notifier).search(value);
  }

  void _cancel(int customerId, int purchaseId) {
    ref.read(purchasesControllerProvider.notifier).modifyStatus(purchaseId, customerId, PurchaseStatus.canceled);
  }
}
