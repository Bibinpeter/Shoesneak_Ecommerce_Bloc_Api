import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/admin/bussiness_logic/admincategory/bloc/categorybloc_bloc.dart';
import 'package:shoesneak/admin/utils/functions/functions.dart';
import 'package:shoesneak/admin/utils/widgets/floatingactionbutton.dart';

class AddProductingScrn extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AddProductingScrn({Key? key});


  Widget _buildListTile(BuildContext context, Map<String, dynamic> category) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 5, 250, 201).withOpacity(0.5),
              spreadRadius: 5,
            ),
          ],
          color:const Color.fromARGB(255, 60, 153, 199)
        ),
        child: ListTile(
          title: Text(category['category'],),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showEditDialog(context, category['category']);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  confirmDelete(context, category['id'], category['category']);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    context.read<CategoryblocBloc>().add(LoadCategory());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'CATEGORIES',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocConsumer<CategoryblocBloc, CategoryblocState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return Column(
              children: [
                Center(
                  child: Text(state.categories.isEmpty ? 'No categories found' : ''),
                ),
                if (state.categories.isNotEmpty)
                  Expanded(
                    child: AnimationList(
                      duration: 2200,
                      reBounceDepth: 13.0, 
                      children: state.categories.map((category) {
                        return _buildListTile(context, category);
                      }).toList(),
                    ),
                  ),
              ],
            );
          } else if (state is CategoryError) {
            return const Center(child: Text('Please wait, there is some issue'));
          }
          return Container();  
        },
      ),
      floatingActionButton: floatingactionbuttonadding(nameController: nameController),
    );
  }
}


