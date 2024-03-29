import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesneak/admin/bussiness_logic/admincategory/bloc/categorybloc_bloc.dart';
import 'package:shoesneak/admin/utils/widgets/elevatedbutton.dart';
import 'package:shoesneak/admin/utils/widgets/textformfield.dart';

// ignore: camel_case_types
class floatingactionbuttonadding extends StatelessWidget {
  const floatingactionbuttonadding({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormFieldWidget(
                      controller: nameController,
                      hintText: 'Name of category',
                      errorText: 'Try another Name',
                    ),
                    const SizedBox(height: 10),
                    ElevatedButtonWidget(
                      onPressed: () {
                        context.read<CategoryblocBloc>().add(
                          AddCategory(name: nameController.text),
                        );
                        Navigator.pop(context);
                        nameController.clear();
                      },
                      buttonText: 'Add Category',
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add,color: Colors.white,),
    );
  }
}