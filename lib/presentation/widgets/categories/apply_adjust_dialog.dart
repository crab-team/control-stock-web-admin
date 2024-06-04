import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/providers/categories/categories_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplyAdjustDialog extends ConsumerStatefulWidget {
  final int categoryId;

  const ApplyAdjustDialog({super.key, required this.categoryId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ApplyAdjustDialogState();
}

class _ApplyAdjustDialogState extends ConsumerState<ApplyAdjustDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Aplicar ajuste'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Estas por aplicar un ajuste a los precios de los productos de esta categoria.'),
          const Gap.small(),
          TextField(
            controller: _controller,
            onChanged: (value) {
              setState(() {});
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Ajuste',
              hintText: '0.00',
              suffix: Text('%'),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            onSubmit();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _controller.text.isEmpty ? colorScheme.disable : colorScheme.primary,
          ),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }

  onSubmit() {
    if (_controller.text.isNotEmpty) {
      ref.read(categoriesControllerProvider.notifier).applyAdjust(widget.categoryId, double.parse(_controller.text));
      Navigator.of(context).pop();
    }
  }
}
