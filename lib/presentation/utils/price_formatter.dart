class PriceFormatter {
  static String formatPrice(double price) {
    final priceString = price.toString();
    const thousandSeparator = ',';
    const decimalSeparator = '.';
    final priceParts = priceString.split('.');
    final integerPart = priceParts[0];
    final decimalPart = priceParts.length > 1 ? priceParts[1] : '00';
    final integerPartFormatted = integerPart.splitMapJoin(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      onMatch: (m) => '${m[1]}$thousandSeparator',
      onNonMatch: (n) => n,
    );

    return '\$$integerPartFormatted$decimalSeparator$decimalPart';
  }
}
