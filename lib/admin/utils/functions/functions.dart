import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoesneak/admin/presentation/adminlogin/adminlogin.dart';

Future<void> adminlogout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', ''); // Set token to empty string
  print('Logged out successfully!');
  Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const Adminlogin(),
      ),
      (route) => false);
}