import 'package:go_router/go_router.dart';
import '../features/contact/contact_page.dart';
import '../features/splash/splash_screen.dart';
import '../features/home/home_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String contact = '/contact';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: home, builder: (context, state) => const HomePage()),
      GoRoute(path: contact, builder: (context, state) => const ContactPage()),
    ],
  );
}
