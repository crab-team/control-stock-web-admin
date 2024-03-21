import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';

enum DialogType { loading, error, success, confirmation }

void useDialogs(BuildContext context,
    {DialogType? type, Widget? content, String? title, List<TextButton>? actionsButton}) {
  if (type == DialogType.loading) return _showLoadingDialog(context);
  if (type == DialogType.error) return _showError(context, content!);
  if (type == DialogType.success) return _showLoadingDialog(context);
  if (type == DialogType.confirmation) {
    return _showConfirmationDialog(context, title!, content!, actionsButton!);
  }
}

void _showLoadingDialog(BuildContext context, [Widget message = const Text("Cargando...")]) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        content: SizedBox(
          height: 200,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const Gap.small(),
                message,
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _showError(BuildContext context, Widget error) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        title: const Text("Error"),
        content: error,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cerrar".toUpperCase(), style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      );
    },
  );
}

void _showConfirmationDialog(
  BuildContext context,
  String title,
  Widget content,
  List<TextButton>? actionsButton,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar".toUpperCase(), style: Theme.of(context).textTheme.bodyLarge),
            ),
            ...actionsButton ?? [],
          ]),
        ],
      );
    },
  );
}
