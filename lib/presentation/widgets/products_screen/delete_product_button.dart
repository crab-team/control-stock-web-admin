import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/hooks/dialogs_hook.dart';
import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteProductButton extends ConsumerWidget {
  final String id;

  const DeleteProductButton(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: colorScheme.onError,
      ),
      onPressed: () => _showConfirmationDialog(context, ref, id),
    );
  }

  void _delete(WidgetRef ref, String id) {}

  _showConfirmationDialog(BuildContext context, WidgetRef ref, String id) {
    useDialogs(
      context,
      type: DialogType.confirmation,
      title: Texts.deleteProduct,
      content: const Text(Texts.deleteProductConfirmation),
      onConfirm: () => _delete(ref, id),
      textConfirmationButton: 'Eliminar',
    );
  }
}
