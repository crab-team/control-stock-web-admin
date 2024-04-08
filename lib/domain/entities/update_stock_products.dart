class UpdateStockProductsParams {
  final int id;
  final int stock;

  UpdateStockProductsParams({required this.id, required this.stock});

  toModel() {
    return {
      'id': id,
      'stock': stock,
    };
  }
}
