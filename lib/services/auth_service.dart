import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:midterm/models/user.dart';

import 'auth_manager.dart';
import 'database_service.dart';

class AuthService {
  final DatabaseService _db = DatabaseService();
  final AuthManager _authManager = AuthManager();

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User?> login(String email, String password) async {
    try {
      if (kDebugMode) {
        print('Attempting login for email: $email');
      }
      final hashedPassword = _hashPassword(password);
      if (kDebugMode) {
        print('Hashed password: $hashedPassword');
      }

      final user = await _db.getUserByEmail(email);
      if (kDebugMode) {
        print('Retrieved user: $user');
      }

      if (user != null && user.password == hashedPassword) {
        if (kDebugMode) {
          print('Login successful');
        }
        return user;
      }

      if (kDebugMode) {
        print('Login failed');
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      return null;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final hashedPassword = _hashPassword(password);
      return await _db.createUser(name, email, hashedPassword);
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }
}