import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoesneak/admin/bussiness_logic/admincategory/bloc/categorybloc_bloc.dart';
import 'package:shoesneak/admin/presentation/adminlogin/adminlogin.dart';
import 'package:shoesneak/admin/utils/widgets/textformfield.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


/////////////////-------ADMIN LOGOUT-----//////////////////////////////////////

Future<void> adminlogout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  // Show custom dialog
  showDialog(
    // ignore: use_build_context_synchronously
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () async {
              await prefs.setString('accessToken', '');
              print('Logged out successfully!');
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const Adminlogin()),
                (route) => false,
                 
              );
              showTopSnackBar(
               snackBarPosition: SnackBarPosition.bottom,
              // ignore: use_build_context_synchronously
              Overlay.of(context),
              const CustomSnackBar.info(message: "successfully loggedout"),
            );
            },
            child: const Text('CONFIRM'),
          ),
          // Back button
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: const Text('BACK'),
          ),
        ],
      );
    },
  );
}

////////////////////////////////---GET TOKEN---///////////////////////////////

Future<String?> getToken() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? '';
  } catch (e) {
    print('Error fetching token: $e');
    throw Exception('Failed to get access token: $e');
  }
}

/////////////////////////////////-----DELETE----//////////////////////////////////////

void confirmDelete(BuildContext context, int id, String categoryName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content:
            Text('Are you sure you want to delete the category $categoryName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CategoryblocBloc>().add(DeleteCategory(id: id));
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}


//////////////////////////////---------EDITING-----////////////////////////////
void showEditDialog(BuildContext context, String categoryName) {
  final editController = TextEditingController(text: categoryName);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormFieldWidget(
                
                controller: editController,
                hintText: 'Category Name',
                errorText: 'Please give a valid name',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 70, 68, 68),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (editController.text.isNotEmpty &&
                          editController.text != categoryName) {
                        context.read<CategoryblocBloc>().add(
                              EditCategory(
                                name: categoryName,
                                newName: editController.text,
                              ),
                            );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

