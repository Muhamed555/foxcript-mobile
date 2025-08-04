import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userEmail;
  String? _userName;

  bool get isAuthenticated => _isAuthenticated;
  String? get userEmail => _userEmail;
  String? get userName => _userName;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _userEmail = prefs.getString('userEmail');
    _userName = prefs.getString('userName');
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any email/password combination
    if (email.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      _userEmail = email;
      _userName = email.split('@')[0]; // Use email prefix as username
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('userEmail', email);
      await prefs.setString('userName', _userName!);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String email, String password, String name) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any valid registration
    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      _isAuthenticated = true;
      _userEmail = email;
      _userName = name;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('userEmail', email);
      await prefs.setString('userName', name);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    _isAuthenticated = false;
    _userEmail = null;
    _userName = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }
} 