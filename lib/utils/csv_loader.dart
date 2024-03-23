import 'package:file_picker/file_picker.dart';

class ProductCsv {
  final String? code;
  final String? name;
  final double? price;
  final int? stock;

  ProductCsv(this.code, this.name, this.price, this.stock);

  toJson() {
    return {
      'code': code,
      'name': name,
      'price': price,
      'stock': stock,
    };
  }
}

class CsvLoader {
  static Future<List<ProductCsv>> upload() async {
    FilePickerResult? csvFile = await FilePicker.platform
        .pickFiles(allowedExtensions: ['csv'], type: FileType.custom, allowMultiple: false, withData: true);

    String s = String.fromCharCodes(csvFile!.files.first.bytes!);
    final rows = s.split('\n');
    final cells = rows.map((e) => e.split(';')).toList();
    List<ProductCsv> csv = [];
    for (var element in cells) {
      if (element.length < 4) {
        continue;
      }

      if (element[0] == 'code') {
        continue;
      }

      final code = element[0];
      final name = element[1];
      String price = element[2] == '' ? '' : parsePrice(element[2]);
      int stock = element[3] == '' || !_isNumber(element[3]) ? 0 : int.parse(element[3]);
      csv.add(
        ProductCsv(
          code,
          name,
          double.parse(price),
          stock,
        ),
      );
    }

    return csv;
  }

  static String parsePrice(String price) {
    return price.replaceAll('\$', '').replaceAll('.', '').replaceAll(',', '.').replaceAll(' ', '').trim();
  }

  static bool _isNumber(String value) {
    return int.tryParse(value) != null;
  }
}
