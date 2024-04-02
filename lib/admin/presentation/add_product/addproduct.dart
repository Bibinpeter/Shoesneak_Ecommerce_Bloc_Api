import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesneak/admin/bussiness_logic/product/bloc/product_bloc.dart';
import 'package:shoesneak/admin/data/model/product.dart';

class AddProductingScrn extends StatelessWidget {
  final List<dynamic> sizes = [
    'W4',
    'W5',
    'W6',
    'W7',
    'W8',
    'W9',
    'W10',
    'M4',
    'M5',
    'M6',
    'M7',
    'M8',
    'M9',
    'M10',
    'K1',
    'K2',
    'K3',
    'K4'
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController productnameController = TextEditingController();
   final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  AddProductingScrn(
      {super.key, required this.categoryName, required this.id});

  final String categoryName;
  final int id;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? selectedSize = sizes[0];
    File? image;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a product'),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductLoading) {
            const Center(child: CircularProgressIndicator());
          } else if (state is ImagePicked) {
            // Update image if pick was successful
            image = state.imageFile;
          } else if (state is ProductPosted) {
            // Show success snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product Added Successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ProductError) {
            // Show error snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('There was an error while adding.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<ProductBloc>(context).add(PickImage());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 95, 162, 198)
                                .withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: image == null
                          ? const Icon(Icons.add_a_photo,
                              size: 50) // Display if no image is selected
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child:
                                  Image.file(image!), // Display selected image
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedSize,
                    hint: const Text('Select Size'),
                    items: sizes.map((size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedSize = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a size.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Stock',
                    ),
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the stock.';
                      }
                      try {
                        int.parse(value); // Check if input is a valid integer
                      } catch (_) {
                        return 'Please enter a valid number for stock.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Price',
                    ),
                    controller: priceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the price.';
                      }
                      try {
                        double.parse(value); // Check if input is a valid double
                      } catch (_) {
                        return 'Please enter a valid price.';
                      }
                      return null;
                    },
                  ),
                    TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'description',
                    ),
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final product = Product(
                          id: id,
                           categoryId: id,
                            description: descriptionController.text,
                             name: nameController.text,
                              price: int.parse(priceController.text),
                                stock:  int.parse(stockController.text),
                                 size: selectedSize ?? '',
                                 
                                 );
              
                        BlocProvider.of<ProductBloc>(context)
                            .add(PostProduct(product: product));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please fix form errors before submitting.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Add Item'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}