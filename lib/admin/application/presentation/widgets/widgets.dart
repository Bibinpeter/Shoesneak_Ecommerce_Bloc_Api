import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/admin/data/model/product.dart';

class ProductCard extends StatelessWidget {
  final ProductFromApi product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3, // Add elevation for a slight shadow effect
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(15),
          //     child: product.image[0]
                 
          //   )
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
