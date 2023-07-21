import 'package:fluro/fluro.dart';
import 'package:admin_dashboard/ui/views/index.dart';

class NoPageFoundHandlers {
  static Handler noPageFound =
      Handler(handlerFunc: (context, params) => const NoPageFoundView());
}
