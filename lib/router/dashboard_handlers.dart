import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/ui/views/index.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView();
    } else {
      return const DashboardView();
    }
  });
}
