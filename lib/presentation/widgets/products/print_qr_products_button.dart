import 'dart:convert';

import 'package:control_stock_web_admin/core/theme.dart';
import 'package:control_stock_web_admin/presentation/hooks/dialogs_hook.dart';
import 'package:control_stock_web_admin/presentation/providers/products/products_data_table_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintQrProductsButton extends ConsumerStatefulWidget {
  const PrintQrProductsButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrintQrProductsButtonState();
}

class _PrintQrProductsButtonState extends ConsumerState<PrintQrProductsButton> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsDataTableStateProvider);
    final hasProductsSelected = products.where((product) => product.selected).isNotEmpty;

    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
            (states) => hasProductsSelected ? colorScheme.primary : colorScheme.primaryContainer),
      ),
      icon: const Icon(PhosphorIcons.printer),
      onPressed: () => hasProductsSelected ? _openPreviewPrint() : null,
      label: const Text(
        'Imprimir QRs',
      ),
    );
  }

  void _openPreviewPrint() {
    final doc = pw.Document();

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        orientation: pw.PageOrientation.portrait,
        build: (pw.Context context) {
          final children = <pw.Widget>[];

          for (final productData in ref.watch(productsDataTableStateProvider)) {
            if (productData.selected) {
              children.add(
                pw.Container(
                  width: 54,
                  height: 74,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Expanded(
                          child:
                              pw.Image(pw.MemoryImage(base64Decode(productData.product.qrCodeUrl!.split(',').last)))),
                      pw.Text(
                        productData.product.code,
                        style: const pw.TextStyle(fontSize: 12, color: PdfColors.black),
                      ),
                    ],
                  ),
                ),
              );
            }
          }

          return pw.Expanded(
              child: pw.Wrap(
            crossAxisAlignment: pw.WrapCrossAlignment.center,
            alignment: pw.WrapAlignment.center,
            runAlignment: pw.WrapAlignment.center,
            children: children,
          ));
        })); // Page

    useDialogs(
      context,
      title: 'Imprimir QRs',
      actionsButton: [
        TextButton(
          onPressed: () => Printing.layoutPdf(onLayout: (format) => doc.save()),
          child: Text('Imprimir'.toUpperCase()),
        ),
      ],
      type: DialogType.confirmation,
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PdfPreview(
          canChangeOrientation: false,
          canChangePageFormat: false,
          enableScrollToPage: true,
          canDebug: false,
          allowSharing: false,
          allowPrinting: false,
          build: (format) => doc.save(),
        ),
      ),
    );
  }
}
