import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/services/index.dart';

import 'package:admin_dashboard/api/backend_api.dart';

import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/providers/index.dart';

import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';

void main() async {
  await LocalStorage.configurePreferences();
  BackendApi.configureDio();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => UserFormProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Admin Dashboard',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        scaffoldMessengerKey: NotificationService.scaffoldKey,
        builder: (context, child) {
          final authProvider = Provider.of<AuthProvider>(context);

          if (authProvider.authStatus == AuthStatus.checking) {
            return const SplashLayout();
          }

          if (authProvider.authStatus == AuthStatus.authenticated) {
            return DashboardLayout(child: child!);
          }

          // print('Token: ');
          // print(LocalStorage.preferences?.getString('token'));
          return AuthLayout(child: child!);
        },
        theme: ThemeData.light().copyWith(
            scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
        )));
  }
}
