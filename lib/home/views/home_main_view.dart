import 'package:authentication_with_bloc/authenticaiton/bloc/authentication_bloc.dart';
import 'package:authentication_with_bloc/login/views/login_main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_screen.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Trending',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Row(
              children: [
                Text('${user?.displayName}'),
                IconButton(
                  icon: Icon(
                    Icons.exit_to_app_outlined,
                  ),
                  onPressed: () =>
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationExited(),
                      ),
                ),
              ],
            ),
          ],
        ),
        body: Center(
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationFailiure) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => LoginMainView()));
              }
            },
            builder: (context, state) {
              if (state is AuthenticationInitial) {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationStarted());
                return CircularProgressIndicator();
              } else if (state is AuthenticationLoading) {
                return CircularProgressIndicator();
              } else if (state is AuthenticationSuccess) {
                return NewsPage();
              }
              return Text('Undefined state : ${state.runtimeType}');
            },
          ),
        ),
      ),
    );
  }
}