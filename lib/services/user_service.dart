import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  String _name = 'Annie Karim';
  String _email = 'annie@example.com';
  String _phone = '+1 234 567 8900';
  final String _profileImage = 'assets/images/profile.jpeg';

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get profileImage => _profileImage;

  void updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    _name = name;
    _email = email;
    _phone = phone;
    notifyListeners();
  }
}
