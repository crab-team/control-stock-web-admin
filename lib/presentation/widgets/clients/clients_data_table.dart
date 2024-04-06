import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/domain/entities/client.dart';
import 'package:control_stock_web_admin/presentation/providers/clients/clients_controller.dart';
import 'package:control_stock_web_admin/presentation/providers/dashboard/drawer_controller.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:control_stock_web_admin/presentation/widgets/clients/client_drawer.dart';
import 'package:control_stock_web_admin/presentation/widgets/clients/clients_data_table_source.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientsDataTable extends ConsumerStatefulWidget {
  const ClientsDataTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientsDataTableState();
}

class _ClientsDataTableState extends ConsumerState<ClientsDataTable> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(clientsControllerProvider);

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

  _buildDataTable(List<Client> data) {
    return PaginatedDataTable2(
      border: dataTableDecoration['border'] as TableBorder,
      minWidth: dataTableDecoration['minWidth'] as double,
      rowsPerPage: dataTableDecoration['rowsPerPage'] as int,
      wrapInCard: dataTableDecoration['wrapInCard'] as bool,
      headingRowHeight: dataTableDecoration['headingRowHeight'] as double,
      dataRowHeight: dataTableDecoration['dataRowHeight'] as double,
      headingRowColor: dataTableDecoration['headingRowColor'] as MaterialStateProperty<Color>,
      actions: [
        const VerticalDivider(
          indent: 8,
          endIndent: 8,
        ),
        SearchBar(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const LinearBorder(),
          ),
          leading: const Icon(PhosphorIcons.magnifying_glass),
          hintText: Texts.searchClient,
          onChanged: (value) => _search(value),
        ),
        const VerticalDivider(
          indent: 8,
          endIndent: 8,
        ),
        const Gap.medium(isHorizontal: true),
        _buildAddClient(),
      ],
      header: Text(
        Texts.clients,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      empty: const Center(child: Text(Texts.noClients)),
      columns: const [
        DataColumn2(
          label: Text(Texts.name),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(Texts.lastName),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(Texts.email),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(Texts.phone),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(Texts.address),
          size: ColumnSize.L,
        ),
        DataColumn2(
          fixedWidth: 150,
          label: Text('Acciones'),
          size: ColumnSize.S,
        ),
      ],
      source: ClientsDataTableSource(data: data, onDelete: _delete),
    );
  }

  void _search(String value) {
    ref.read(clientsControllerProvider.notifier).search(value);
  }

  void _delete(int id) {
    ref.read(clientsControllerProvider.notifier).delete(id);
  }

  Widget _buildAddClient() {
    return ElevatedButton.icon(
      icon: const Icon(PhosphorIcons.plus),
      onPressed: () => _openDrawer(context, ref),
      label: const Text(Texts.addClient),
    );
  }

  _openDrawer(BuildContext context, WidgetRef ref) {
    ref.read(drawerController.notifier).state = const ClientDrawer();
  }
}
