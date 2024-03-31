import 'package:flutter/material.dart';
import 'package:shoesneak/application/presentation/screens/userscreens/widgets/refreshingwidget.dart';
import 'package:shoesneak/domain/core/constrains/const.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override   
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: kwhiteColor,  
        body: WarpIndicator(
          child: ListView.builder(  
            itemCount: 20,
            itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
          ),
          onRefresh: () async {
            // Simulate a delay of 2 seconds to mimic refreshing behavior
            await Future.delayed(Duration(seconds: 2));
          },
        ),
      );
    
      
      
  }
}