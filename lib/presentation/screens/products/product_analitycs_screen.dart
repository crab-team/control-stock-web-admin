import 'package:control_stock_web_admin/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductAnalyticsScreen extends ConsumerStatefulWidget {
  final Product? product;
  const ProductAnalyticsScreen({super.key, this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductAnalyticsScreenState();
}

class _ProductAnalyticsScreenState extends ConsumerState<ProductAnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
