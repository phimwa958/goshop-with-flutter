import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'providers/order_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/change_password_screen.dart';
import 'screens/products/product_list_screen.dart';
import 'screens/products/product_detail_screen.dart';
import 'screens/orders/place_order_screen.dart';
import 'screens/orders/order_list_screen.dart';
import 'screens/orders/order_detail_screen.dart';
import 'screens/profile/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: Builder(
        builder: (context) {
          final router = GoRouter(
            initialLocation: '/products',
            redirect: (context, state) {
              final authProvider = context.read<AuthProvider>();
              final isAuthenticated = authProvider.isAuthenticated;
              final isAuthRoute = state.matchedLocation == '/login' ||
                  state.matchedLocation == '/register';

              // Redirect to login if not authenticated and trying to access protected routes
              if (!isAuthenticated &&
                  !isAuthRoute &&
                  state.matchedLocation != '/products' &&
                  !state.matchedLocation.startsWith('/products/')) {
                return '/login';
              }

              return null;
            },
            routes: [
              GoRoute(
                path: '/login',
                builder: (context, state) => const LoginScreen(),
              ),
              GoRoute(
                path: '/register',
                builder: (context, state) => const RegisterScreen(),
              ),
              GoRoute(
                path: '/products',
                builder: (context, state) => const ProductListScreen(),
              ),
              GoRoute(
                path: '/products/:id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return ProductDetailScreen(productId: id);
                },
              ),
              GoRoute(
                path: '/cart',
                builder: (context, state) => const PlaceOrderScreen(),
              ),
              GoRoute(
                path: '/orders',
                builder: (context, state) => const OrderListScreen(),
              ),
              GoRoute(
                path: '/orders/:id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return OrderDetailScreen(orderId: id);
                },
              ),
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
              GoRoute(
                path: '/change-password',
                builder: (context, state) => const ChangePasswordScreen(),
              ),
            ],
          );

          return MaterialApp.router(
            title: 'GoShop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              // Accessibility: Ensure minimum touch target sizes
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            themeMode: ThemeMode.system,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
