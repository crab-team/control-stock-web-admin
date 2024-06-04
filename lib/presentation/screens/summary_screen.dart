import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryScreen extends ConsumerStatefulWidget {
  const SummaryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends ConsumerState<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItem(Icons.shopping_cart, 'Cantidad', '10'),
              _buildItem(Icons.attach_money, 'Subtotal', '\$ 1000'),
              _buildItem(Icons.money_off, 'Descuento', '\$ 100'),
            ],
          ),
          const Gap.medium(),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String title, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon),
              const Gap.small(),
              Text(title),
              const Gap.small(),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}
