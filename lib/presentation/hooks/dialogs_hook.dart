import 'package:flutter/material.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/loading_dialog.dart';

enum DialogType { loading, error, success }

void useDialogs(BuildContext context, {DialogType? type, String? message}) {
  if (type == DialogType.loading) _showLoadingDialog(context);
  if (type == DialogType.error) _showError(context, message!);
  if (type == DialogType.success) _showLoadingDialog(context);
}

void _showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const LoadingDialog();
    },
  );
}

void _showError(BuildContext context, String error) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Error"),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cerrar"),
          ),
        ],
      );
    },
  );
}
