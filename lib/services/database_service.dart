import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';
import '../models/user.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  MySqlConnection? _conn;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<void> connect() async {
    // server mysql
    final settings = ConnectionSettings(
      host: '127.0.0.1',
      port: 3306,
      user: 'flutter',
      password: 'password',
      db: 'flutter',
    );

    try {
      _conn = await MySqlConnection.connect(settings);
      if (kDebugMode) {
        print('Database connected successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Database connection failed: $e');
      }
      rethrow;
    }
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      if (_conn == null) {
        await connect();
      }

      final results = await _conn!.query(
        'SELECT * FROM users WHERE email = ?',
        [email],
      );

      if (results.isNotEmpty) {
        if (kDebugMode) {
          print('Database result: ${results.first.fields}');
        } // Debug log
        return User(
          id: results.first['id'],
          name: results.first['name'],
          email: results.first['email'],
          password: results.first['password'],
          point: results.first['point'] ?? 0,
        );
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting user: $e');
      }
      return null;
    }
  }

  Future<bool> createUser(String name, String email, String password) async {
    try {
      if (_conn == null) {
        await connect();
      }

      await _conn!.query(
        'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
        [name, email, password],
      );
      print('User created successfully');
      return true;
    } catch (e) {
      print('Error creating user: $e');
      return false;
    }
  }
}