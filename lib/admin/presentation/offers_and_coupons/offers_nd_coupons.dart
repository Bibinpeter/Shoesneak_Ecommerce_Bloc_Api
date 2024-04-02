import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OffersAndCouponsAddingScreen extends StatelessWidget {
  const OffersAndCouponsAddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Offers and Coupons',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'COUPOUNS'),
              Tab(text: 'OFFERS'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Coupons Tab Content')),
            Center(child: Text('Offers Tab Content')),
          ],
        ),
      ),
    );
  }
}