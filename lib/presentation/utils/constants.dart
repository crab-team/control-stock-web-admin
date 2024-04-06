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

  // Categories
  static const String categories = 'Categorías';
  static const String createCategory = 'Crear categoría';
  static const String updateCategory = 'Actualizar categoría';
  static const String deleteCategory = 'Eliminar categoría';
  static const String deleteCategoryConfirmation = '¿Está seguro que desea eliminar esta categoría?';
  static const String noCategories = 'No hay categorías';
  static const String searchCategory = 'Buscar categoría';
  static const String percentageProfit = 'Porcentaje de ganancia';

  // Clients
  static const String clients = 'Clientes';
  static const String createClient = 'Crear cliente';
  static const String updateClient = 'Actualizar cliente';
  static const String deleteClient = 'Eliminar cliente';
  static const String deleteClientConfirmation = '¿Está seguro que desea eliminar este cliente?';
  static const String noClients = 'No hay clientes';
  static const String searchClient = 'Buscar cliente';
  static const String addClient = 'Agregar cliente';
  static const String editClient = 'Editar cliente';

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
