 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/admin/bussiness_logic/admincategory/bloc/categorybloc_bloc.dart';
import 'package:shoesneak/admin/presentation/add_product/addproduct.dart';
import 'package:shoesneak/admin/utils/functions/functions.dart';
import 'package:shoesneak/admin/utils/widgets/elevatedbutton.dart';
import 'package:shoesneak/admin/utils/widgets/textformfield.dart';

class AddCategoryScrn extends StatelessWidget {
  const AddCategoryScrn({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    context.read<CategoryblocBloc>().add(LoadCategory());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Categories',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocConsumer<CategoryblocBloc, CategoryblocState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryLoading) {
            Future.delayed(const Duration(milliseconds: 500), () {
              return const Center(child: CircularProgressIndicator());
            });
          } else if (state is CategoryLoaded) {
            return Column(
              children: [
                Center(
                  child: Text(
                      state.categories.isEmpty ? 'No categories found' : ''),
                ),
                if (state.categories.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddProductingScrn(
                            id: category['id'],
                            categoryName: category['category'],
                          ),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListTile(
                                title: Text(category['category']),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        showEditDialog(
                                            context, category['category']);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        confirmDelete(context, category['id'],
                                            category['category']);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          } else if (state is CategoryError) {
            return const Center(
                child: Text('please wait there is some issue '));
          }
          return Container(); // Handle unexpected states
        },
      ),
      floatingActionButton: FloatingActionButton(
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
                      TextFormFieldWidgetadmin(
                          controller: nameController,
                          hintText: 'Category Name',
                          errorText: 'Enter a valid category name'),
                      
                      ElevatedButtonWidget(
                          onPressed: () {
                            context.read<CategoryblocBloc>().add(
                                  AddCategory(name: nameController.text),
                                );
                            Navigator.pop(context);
                            nameController.clear();
                          },
                          buttonText: 'Add Category')
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}