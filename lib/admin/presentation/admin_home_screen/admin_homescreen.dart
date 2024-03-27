import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/admin/utils/functions/functions.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    adminlogout(context);
                    showTopSnackBar(
                      curve: Curves.bounceOut,
                      animationDuration: const Duration(milliseconds: 800),
                      displayDuration: const Duration(milliseconds: 1500),
                      snackBarPosition: SnackBarPosition.bottom,
                      Overlay.of(context),
                      const CustomSnackBar.info(message: "LOGOUT successfully"),
                    );
                  },
                  icon: const Icon(Icons.logout))
            ],
            title: Text(
              'Nikey Nike',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            elevation: 0,
            centerTitle: true),
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            product: products[index],
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;

  Product({required this.name, required this.imageUrl});
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Ink.image(
            image: NetworkImage(product.imageUrl),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {},
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                product.name,
                style: GoogleFonts.poppins(
                  color: Colors.white, // Set text color to white
                  fontSize: 16,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

final List<Product> products = [
  Product(
      name: 'Product 1',
      imageUrl:
          'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/f50070d2-77a3-4213-aebf-9371d9759548/air-max-dn-shoes-FtLNfm.png'),
  Product(
      name: 'Product 2',
      imageUrl:
          'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/35c07f69-1d7a-4272-abe4-4adf4b9a9d2f/air-max-dn-shoes-FtLNfm.png'),
  Product(
      name: 'Product 3',
      imageUrl:
          'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/2653d8a9-9c70-418e-829b-d70fe2737514/air-max-dn-shoes-FtLNfm.png'),
  Product(
      name: 'Product 4',
      imageUrl:
          'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/71fea927-0152-4265-9cd1-33e58e62d73e/air-max-dn-shoes-FtLNfm.png'),
  Product(
      name: 'Product 5',
      imageUrl:
          'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/2b21aa76-422c-4682-bdd7-067c0ffc36e4/air-max-plus-drift-shoes-FCM3Rg.png'),
  Product(
      name: 'Product 6',
      imageUrl:
          'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/4e5e7079-cafa-4ed0-9e30-4506daef8274/air-max-plus-3-shoes-tCDqdH.png'),
  Product(
      name: 'Product 7',
      imageUrl:
          'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/4763b078-c16f-44bd-a5d0-2fcad00b653c/air-max-excee-shoes-Zvl8cs.png'),
  Product(
      name: 'Product 8',
      imageUrl:
          'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/1366f27d-1336-4e4e-809e-1c6e2e0be227/air-max-270-shoes-2V5C4p.png'),
];