  import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoesneak/admin/utils/widgets/elevatedbutton.dart';
import 'package:shoesneak/application/presentation/screens/auth/loginscreen.dart';

Future<void> userlogout(BuildContext context) async {
  // Show confirmation dialog
  bool confirmLogout = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: AlertDialog(
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButtonWidget(
                  buttonText: 'Yes',
                  onPressed: () {
                    Navigator.of(context)
                        .pop(true); // Return true when confirmed
                  },
                ),
                ElevatedButtonWidget(
                  buttonText: 'No',
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Return false when canceled
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
  // If user confirms logout, proceed with logout process
  if (confirmLogout == true) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', ''); // Set token to empty string
    print('Logged out successfully!');
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }
}
