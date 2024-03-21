import 'package:control_stock_web_admin/core/router.dart';
import 'package:control_stock_web_admin/presentation/providers/sign_in/sign_controller.dart';
import 'package:control_stock_web_admin/presentation/widgets/shared/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailLinkConfirmationScreen extends ConsumerWidget {
  final String token;
  const EmailLinkConfirmationScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
        future: ref.read(exchangeTokenController(token).future),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return _buildError(context, snapshot.error.toString());
            }

            _goToNextScreen(context, ref);
            return _buildSuccess(context);
          }
          return _buildLoading(context);
        },
      ),
    );
  }

  _goToNextScreen(BuildContext context, WidgetRef ref) {
    ref.read(navigationServiceProvider).goToHome(context);
  }

  _buildSuccess(BuildContext context) {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check, color: Colors.green, size: 50),
          Gap.medium(),
          Text("Autenticación exitosa"),
        ],
      ),
    );
  }

  _buildError(BuildContext context, Object error) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 50),
          const Gap.medium(),
          Text("Error: $error"),
        ],
      ),
    );
  }

  _buildLoading(BuildContext context) {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Gap.medium(),
          Text("Autenticando y redireccionando..."),
        ],
      ),
    );
  }
}
