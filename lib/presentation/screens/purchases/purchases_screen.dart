import 'package:control_stock_web_admin/presentation/widgets/purchases/purchases_data_table.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchasesScreen extends ConsumerWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PurchasesDataTable();
  }
}
