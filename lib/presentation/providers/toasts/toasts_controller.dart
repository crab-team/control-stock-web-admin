import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToastControllerModel {
  final String title;
  final String message;
  final ToastType type;

  ToastControllerModel(this.title, this.message, this.type);
}

final toastsControllerProvider = NotifierProvider<ToastsController, ToastControllerModel?>(ToastsController.new);

class ToastsController extends Notifier<ToastControllerModel?> {
  @override
  ToastControllerModel? build() {
    return null;
  }

  showToast(ToastControllerModel toastController) {
    state = toastController;
  }
}
