import 'package:currency_formatter/currency_formatter.dart';

class AssetsImages {
  static const String logo = 'assets/images/logo.png';
  static const String logoMtc = 'assets/images/logo_mtc.png';
  static const String background = 'assets/images/background.jpg';
}

class Texts {
  static const String accept = 'Aceptar';
  static const String cancel = 'Cancelar';
  static const String save = 'Guardar';
  static const String edit = 'Editar';
  static const String add = 'Agregar';
  static const String delete = 'Eliminar';
  static const String update = 'Actualizar';
  static const String requiredField = 'Campo requerido';
  static const String requiredFieldMessage = 'Recuerda completar todos\nlos campos obligatorios';
  static const String name = 'Nombre';
  static const String lastName = 'Apellido';
  static const String description = 'Descripción';
  static const String price = 'Precio';
  static const String stock = 'Stock';
  static const String code = 'Código';
  static const String loading = 'Cargando...';
  static const String noImage = 'Sin imagen';
  static const String noData = 'No hay datos';
  static const String saved = 'Guardado';
  static const String quantity = 'Cantidad';
  static const String quantityAbbreviation = 'Cant.';
  static const String total = 'Total';
  static const String actions = 'Acciones';
  static const String resume = 'Resumen';
  static const String confirming = 'Confirmando...';
  static const String record = 'Ficha';
  static const String paymentStatus = 'Estado de pago';
  static const String paymentMethod = 'Método de pago';
  static const String surcharge = 'Recargo';
  static const String unitPrice = 'Precio/u';
  static const String debt = 'Adeuda';
  static const String give = 'Entrega';

  // Commerce
  static const String email = 'Correo electrónico';
  static const String address = 'Dirección';
  static const String phone = 'Teléfono';
  static const String discountCashPercentage = 'Descuento en efectivo';
  static const String commerce = 'Comercio';
  static const String commerceName = 'Nombre del comercio';
  static const String accountingData = 'Datos contables';
  static const String commerceSettings = 'Configuración de comercio';
  static const String commerceData = 'Datos del comercio';
  static const String commerceImage = 'Imagen del comercio';
  static const String commerceImageDescription = 'Haga clic en la imagen para cambiarla';

  // Products
  static const String products = 'Productos';
  static const String createProduct = 'Crear producto';
  static const String updateProduct = 'Actualizar producto';
  static const String deleteProduct = 'Eliminar producto';
  static const String deleteProductConfirmation = '¿Está seguro que desea eliminar este producto?';
  static const String noProducts = 'No hay productos';
  static const String searchProduct = 'Buscar producto';
  static const String uploadCsvProductsScreenTitle = 'Subir productos desde CSV';
  static const String uploadCsv = 'Subir CSV';
  static const String addProduct = 'Agregar producto';
  static const String productName = 'Nombre del producto';

  // Categories
  static const String categories = 'Categorías';
  static const String createCategory = 'Crear categoría';
  static const String updateCategory = 'Actualizar categoría';
  static const String deleteCategory = 'Eliminar categoría';
  static const String deleteCategoryConfirmation = '¿Está seguro que desea eliminar esta categoría?';
  static const String noCategories = 'No hay categorías';
  static const String searchCategory = 'Buscar categoría';
  static const String percentageProfit = 'Porcentaje de ganancia';

  // Customers
  static const String customer = 'Cliente';
  static const String customers = 'Clientes';
  static const String createCustomer = 'Crear cliente';
  static const String noCustomer = 'No hay clientes';
  static const String searchCustomer = 'Buscar cliente';
  static const String addCustomer = 'Agregar cliente';
  static const String editCustomer = 'Editar cliente';
  static const String noRecords = 'No hay registros';
  static const String records = 'Ficha';
  static const String searchRecord = 'Buscar registro';
  static const String addRecord = 'Agregar registro';

  // Orders
  static const String shopping = 'Compras';
  static const String orders = 'Órdenes de compra';
  static const String createOrder = 'Crear orden';
  static const String updateOrder = 'Actualizar orden';
  static const String deleteOrder = 'Eliminar orden';
  static const String deleteOrderConfirmation = '¿Está seguro que desea eliminar esta orden?';
  static const String noOrders = 'No hay órdenes';
  static const String searchOrder = 'Buscar orden';
  static const String addOrder = 'Agregar orden';
  static const String editOrder = 'Editar orden';
  static const String orderDetails = 'Detalles de la orden';
  static const String confirmOrder = 'Confirmar orden';
  static const String orderSummary = 'Resumen de la orden';
  static const String orderProducts = 'Productos de la orden';
  static const String orderProductsManager = 'Gestor de productos de la orden';
  static const String confirmPurchase = 'Confirmar compra';
  static const String orderPurchaseConfrimated = 'Compra confirmada';
  static const String orderPurchaseConfrimatedMessage = 'La compra ha sido confirmada';

  // Payment methods
  static const String paymentMethods = 'Métodos de pago';
  static const String createPaymentMethod = 'Crear método de pago';
  static const String updatePaymentMethod = 'Actualizar método de pago';
  static const String deletePaymentMethod = 'Eliminar método de pago';
  static const String deletePaymentMethodConfirmation = '¿Está seguro que desea eliminar este método de pago?';
  static const String noPaymentMethods = 'No hay métodos de pago';
  static const String searchPaymentMethod = 'Buscar método de pago';
  static const String addPaymentMethod = 'Agregar método de pago';
  static const String editPaymentMethod = 'Editar método de pago';
  static const String installments = 'Cuotas';
  static const String surchargePercentage = 'Porcentaje de recargo';

  // Errors
  static const String error = 'Error';
  static const String errorOccurred = 'Ocurrió un error';
  static const String errorOccurredTryAgain = 'Ocurrió un error, intente nuevamente';
}

CurrencyFormat arsSettings = const CurrencyFormat(
  code: 'ars',
  symbol: '\$',
  symbolSide: SymbolSide.left,
  thousandSeparator: '.',
  decimalSeparator: ',',
  symbolSeparator: ' ',
);
