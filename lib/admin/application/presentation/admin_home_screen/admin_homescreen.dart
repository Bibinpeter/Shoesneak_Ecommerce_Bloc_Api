import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesneak/admin/application/bussiness_logic/product/bloc/product_bloc.dart';
import 'package:shoesneak/admin/application/presentation/widgets/widgets.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchProducts()); // Trigger FetchProducts event

    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          return GridView.builder(
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(product:state.products[index]);
            },
          );
        } else if (state is ProductError) {
          // Handle ProductError state and display error message
          return Center(child: Text('Error fetching products'));
        } else {
          // Handle other states or show a default loading indicator
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
