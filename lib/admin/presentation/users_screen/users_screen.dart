
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/admin/bussiness_logic/users_bloc/bloc/users_bloc.dart';
import 'package:shoesneak/admin/utils/functions/functions.dart';
import 'package:shoesneak/domain/core/constrains/const.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UsersBloc>(context).add(FetchUsers());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Column(
                      children: [Text('do you want tologout')],
                    );
                  },
                );
                adminlogout(context);
              },
              icon: const Icon(Icons.logout))
        ],
        centerTitle: true,
        title: Text(
          'Users',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UsersLoaded) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(user.firstname),
                    subtitle: Text(user.email),
                    trailing: ElevatedButton(
                      onPressed: () {
                        print('the user blocstatus is ${user.blockStatus}');
                        if (user.blockStatus == true) {
                          BlocProvider.of<UsersBloc>(context)
                              .add(UnblockUser(user.id));
                          BlocProvider.of<UsersBloc>(context).add(FetchUsers());
                        } else if (user.blockStatus== false) {
                          BlocProvider.of<UsersBloc>(context)
                              .add(BlockUser(user.id));
                          BlocProvider.of<UsersBloc>(context).add(FetchUsers());
                        }
                      },
                      child: Text(user.blockStatus == true ? 'unlock' : 'block'),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => kSizedBoxH10,
              itemCount: state.users.length,
            );
          } else if (state is UsersError) {
            return const Center(
              child: Text('No User Found'),
            );
          } else {
            return const Center(
              child: Text('Data could not be fetched'),
            );
          }
        },
        listener: (context, state) {
          if (state is UserBlocked) {
           showTopSnackBar(
              curve: Curves.bounceOut,
              animationDuration: const Duration(milliseconds: 500),
              displayDuration: const Duration(milliseconds: 1500),
              snackBarPosition: SnackBarPosition.bottom,
            Overlay.of(context),const CustomSnackBar.success(message:"User successfully Blocked"),
            );
          } else if (state is UserUnblocked) {
           showTopSnackBar(
              curve: Curves.bounceOut,
              animationDuration: const Duration(milliseconds: 500),
              displayDuration: const Duration(milliseconds: 1500),
              snackBarPosition: SnackBarPosition.bottom,
            Overlay.of(context),const CustomSnackBar.success(message:"User successfully UNBlocked"),
            );
          }
        },
      ),
    );
  }
  

}