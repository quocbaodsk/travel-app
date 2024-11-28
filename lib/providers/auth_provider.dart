import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_manager.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  final AuthManager _authManager = AuthManager();
  bool isLoading = false;
  bool needLogin = false;

  User? get currentUser => _currentUser;

  AuthProvider() {
    loadUser();
  }


  Future<void> loadUser() async {
    try {
      isLoading = true;
      notifyListeners();

      _currentUser = await _authManager.getCurrentUser();

      if (_currentUser == null) {
        needLogin = true;
      } else {
        needLogin = false;
      }

    } catch (e) {
      if (kDebugMode) {
        print('Error loading user: $e');
      }
      needLogin = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setUser(User user) async {
    _currentUser = user;
    needLogin = false;
    await _authManager.saveUserLogin(user);
    notifyListeners();
  }

  Future<void> logout() async {
    await _authManager.logout();
    _currentUser = null;
    needLogin = true;
    notifyListeners();
  }
}