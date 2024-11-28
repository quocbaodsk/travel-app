import 'package:flutter/material.dart';
import 'package:midterm/screens/splash_screen.dart';
import '../navigation/main_navigation.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/profile_setting_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/booking/flight_selection_screen.dart';
import '../screens/booking/date_selection_screen.dart';
import '../screens/booking/flight_booking_screen.dart';

class AppRoutes {
  static const String splash = '/'; // Thêm splash route
  // static const String initial = '/'; // Thêm route mặc định
  static const String main = '/main'; // Thêm main route
  static const String login = '/login';
  static const String register = '/register';

  static Map<String, Widget Function(BuildContext)> routes = {
    // initial: (context) => const LoginScreen(),
    splash: (context) => const SplashScreen(),
    main: (context) => const MainNavigation(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),

    // booking
    '/flight_booking': (context) => const FlightBookingScreen(),
    '/date_selection': (context) => const DateSelectionScreen(),
    '/flight_selection': (context) => const FlightSelectionScreen(),

    // profile
    '/profile': (context) => const ProfileScreen(),
    '/profile-settings': (context) => const ProfileSettingScreen(),
  };
}
