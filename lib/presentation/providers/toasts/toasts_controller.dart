import 'package:control_stock_web_admin/utils/toast_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToastController {
  final String title;
  final String message;
  final ToastType type;

  ToastController(this.title, this.message, this.type);
}

final toastsControllerProvider = NotifierProvider<ToastsController, ToastController?>(ToastsController.new);

class ToastsController extends Notifier<ToastController?> {
  @override
  ToastController? build() {
    return null;
  }

  showToast(ToastController toastController) {
    state = toastController;
  }
}
