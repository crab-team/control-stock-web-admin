import 'package:control_stock_web_admin/core/error_handlers/app_error.dart';
import 'package:control_stock_web_admin/core/error_handlers/error_code.dart';
import 'package:fpdart/fpdart.dart';
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

class ProductsCsvLoader {
  static Future<Either<AppError, List<ProductCsv>>> upload() async {
    try {
      FilePickerResult? csvFile = await FilePicker.platform.pickFiles(
        allowedExtensions: ['csv'],
        type: FileType.custom,
        allowMultiple: false,
        withData: true,
      );

      if (csvFile == null || csvFile.files.isEmpty) {
        return const Right([]);
      }

      String s = String.fromCharCodes(csvFile.files.first.bytes!);
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
        double price = element[2] == '' ? 0.0 : parsePrice(element[2]);
        int stock = element[3] == '' || !_isNumber(element[3]) ? 0 : int.parse(element[3]);
        csv.add(
          ProductCsv(
            code,
            name,
            price,
            stock,
          ),
        );
      }

      return Right(csv);
    } on FormatException catch (_) {
      return Left(AppError.handle(ErrorCode.FORMAT_EXCEPTION));
    } catch (e) {
      return Left(AppError.handle(ErrorCode.UNEXPECTED_ERROR));
    }
  }

  static double parsePrice(String price) {
    String parse = price.replaceAll('\$', '').replaceAll('.', '').replaceAll(',', '.').replaceAll(' ', '').trim();
    return double.tryParse(parse) ?? 0.0;
  }

  static bool _isNumber(String value) {
    return int.tryParse(value) != null;
  }
}
