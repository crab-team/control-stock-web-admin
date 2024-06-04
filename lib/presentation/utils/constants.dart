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
  static const String stock = 'Cantidad';
  static const String code = 'Código';
  static const String loading = 'Cargando...';
  static const String noImage = 'Sin imagen';
  static const String noData = 'No hay datos';
  static const String saved = 'Guardado';
  static const String quantity = 'Cantidad';
  static const String quantityAbbreviation = 'Cant.';
  static const String subtotal = 'Subtotal';
  static const String total = 'Total';
  static const String actions = 'Acciones';
  static const String resume = 'Resumen';
  static const String confirming = 'Confirmando...';
  static const String record = 'Ficha';
  static const String paymentStatus = 'Estado de pago';
  static const String paymentMethod = 'Método de pago';
  static const String selectPaymentMethod = 'Seleccionar método de pago';
  static const String surcharge = 'Recargo';
  static const String discount = 'Descuento';
  static const String unitPrice = 'Precio/u';
  static const String debt = 'Adeuda';
  static const String give = 'Entrega';
  static const String returnMoney = 'Devuelve';
  static const String operationSuccess = 'Operación exitosa';
  static const String operationSuccessMessage = 'La operación ha sido exitosa';
  static const String createdAt = 'Fecha de creación';
  static const String valueSuperiorToTotal = 'El monto no puede ser mayor al total de la compra.';
  static const String summary = 'Resumen';
  static const String goToAdmin = 'Ir a administrador';
  static const String change = 'Cambiar';
  static const String paid = 'Pagado';
  static const String customerGiveMoney = 'Cliente entrega dinero';
  static const String commerceReturnMoney = 'Comercio devuelve dinero';
  static const String scanQR = 'Escanear QR';
  static const String print = 'Imprimir';
  static const String applyAdjust = 'Aplicar ajuste';

  // Commerce
  static const String email = 'Correo electrónico';
  static const String address = 'Dirección';
  static const String phone = 'Teléfono';
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
  static const String pressAddProduct = 'Presiona el botón para agregar un producto';
  static const String searchProduct = 'Buscar producto';
  static const String uploadCsvProductsScreenTitle = 'Subir productos desde CSV';
  static const String uploadCsv = 'Subir CSV';
  static const String addProduct = 'Agregar producto';
  static const String productName = 'Nombre del producto';
  static const String allProductsUpdated = 'Todos los productos han sido actualizados';
  static const String deletingProduct = 'Eliminando producto';
  static const String errorDeletingProduct = 'Error al eliminar producto';
  static const String updatingProduct = 'Actualizando producto';
  static const String errorUpdatingProduct = 'Error al actualizar producto';
  static const String creatingProduct = 'Creando producto';
  static const String errorCreatingProduct = 'Error al crear producto';
  static const String productCreated = 'Producto creado correctamente';
  static const String productUpdated = 'Producto actualizado correctamente';
  static const String productDeleted = 'Producto eliminado correctamente';
  static const String creatingProducts = 'Creando productos';
  static const String updatingProducts = 'Actualizando productos';
  static const String errorCreatingProducts = 'Error al crear productos';
  static const String errorUpdatingProducts = 'Error al actualizar productos';
  static const String productsCreated = 'Productos creados correctamente';
  static const String productsUpdated = 'Productos actualizados correctamente';
  static const String errorUploadingCsv = 'Error al subir archivo CSV';
  static const String selectProduct = 'Seleccionar un producto';

  // Categories
  static const String categories = 'Categorías';
  static const String createCategory = 'Crear categoría';
  static const String updateCategory = 'Actualizar categoría';
  static const String deleteCategory = 'Eliminar categoría';
  static const String deleteCategoryConfirmation = '¿Está seguro que desea eliminar esta categoría?';
  static const String noCategories = 'No hay categorías';
  static const String searchCategory = 'Buscar categoría';
  static const String percentageProfit = 'Porcentaje de ganancia';
  static const String extraCosts = 'Costos extras';
  static const String creatingCategory = 'Creando categoría';
  static const String errorCreatingCategory = 'Error al crear categoría';
  static const String categoryCreated = 'Categoría creada';
  static const String updatingCategory = 'Actualizando categoría';
  static const String errorUpdatingCategory = 'Error al actualizar categoría';
  static const String categoryUpdated = 'Categoría actualizada';
  static const String deletingCategory = 'Eliminando categoría';
  static const String errorDeletingCategory = 'Error al eliminar categoría';
  static const String categoryDeleted = 'Categoría eliminada';
  static const String applyingAdjust = 'Aplicando ajuste';
  static const String errorApplyingAdjust = 'Error al aplicar ajuste';
  static const String adjustApplied = 'Ajuste aplicado';

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
  static const String balance = 'Saldo';
  static const String selectCustomer = 'Seleccionar cliente';

  // Purchases
  static const String purchases = 'Compras';
  static const String orders = 'Órdenes de compra';
  static const String createOrder = 'Crear orden';
  static const String updateOrder = 'Actualizar orden';
  static const String deleteOrder = 'Eliminar orden';
  static const String deleteOrderConfirmation = '¿Está seguro que desea eliminar esta orden?';
  static const String noOrders = 'No hay órdenes';
  static const String searchOrder = 'Buscar orden';
  static const String addPurchase = 'Agregar compra';
  static const String purchaseDetails = 'Detalles de la compra';
  static const String createPurchase = 'Crear compra';
  static const String editPurchase = 'Editar compra';
  static const String noPurchases = 'No hay compras';
  static const String searchPurchase = 'Buscar compra';
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
  static const String addingOrder = 'Agregando orden';
  static const String errorAddingOrder = 'Error al agregar orden';
  static const String orderAdded = 'Orden agregada';
  static const String deletingOrder = 'Eliminando orden';
  static const String errorDeletingOrder = 'Error al eliminar orden';
  static const String orderDeleted = 'Orden eliminada';
  static const String updatingOrder = 'Actualizando orden';
  static const String errorUpdatingOrder = 'Error al actualizar orden';
  static const String orderUpdated = 'Orden actualizada';
  static const String confirmingOrder = 'Confirmando orden';
  static const String errorConfirmingOrder = 'Error al confirmar orden';
  static const String deletingPurchase = 'Eliminando compra';
  static const String errorDeletingPurchase = 'Error al eliminar compra';
  static const String purchaseDeleted = 'Compra eliminada';
  static const String purchaseStatus = 'Estado de la compra';
  static const String updatingPurchaseStatus = 'Actualizando estado de la compra';
  static const String errorUpdatingPurchaseStatus = 'Error al actualizar estado de la compra';
  static const String purchaseStatusUpdated = 'Estado de la compra actualizado';
  static const String updatingPurchase = 'Actualizando compra';
  static const String errorUpdatingPurchase = 'Error al actualizar compra';
  static const String purchaseUpdated = 'Compra actualizada';
  static const String errorCancelingPurchase = 'Error al cancelar compra';
  static const String purchaseCanceled = 'Compra cancelada';

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
  static const String useBalance = 'Usar saldo en cuenta';

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

RegExp currencyInputFormatter = RegExp(r'^\d*[,]?\d*');
