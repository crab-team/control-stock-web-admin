import 'package:control_stock_web_admin/core/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadCsvButton extends ConsumerStatefulWidget {
  const UploadCsvButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadCsvButtonState();
}

class _UploadCsvButtonState extends ConsumerState<UploadCsvButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.upload_file),
      onPressed: () => ref.read(navigationServiceProvider).goToUploadCsvProducts(context),
      label: const Text('Subir CSV'),
    );
  }
}
