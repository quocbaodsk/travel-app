import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'database_service.dart';

class AuthManager {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserId = 'userId';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyUserName = 'userName';
  final DatabaseService _db = DatabaseService(); // Thêm DatabaseService

  static final AuthManager _instance = AuthManager._internal();

  factory AuthManager() {
    return _instance;
  }


  AuthManager._internal();

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }


  Future<User?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      final userEmail = prefs.getString('userEmail');

      if (userId == null || userEmail == null) {
        return null;
      }

      // Kiểm tra xem user có tồn tại trong database không
      final DatabaseService db = DatabaseService();
      final user = await db.getUserByEmail(userEmail);

      if (user == null) {
        // User không tồn tại trong database
        await logout();  // Xóa thông tin đăng nhập
        return null;
      }

      return user;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting current user: $e');
      }
      return null;
    }
  }

  Future<void> saveUserLogin(User user) async {
    final prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print('Saving user login: ${user.email}');
    }
    await prefs.setBool('isLoggedIn', true);
    await prefs.setInt('userId', user.id);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('userName', user.name);
    if (kDebugMode) {
      print('User login saved successfully');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

}