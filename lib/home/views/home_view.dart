
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto_currency/authenticaiton/bloc/authentication_bloc.dart';
import 'package:crypto_currency/constants/constants.dart';
import 'package:crypto_currency/login/views/login_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            'Breaking News',
            style: kAppbarStyle,
          ),
          actions: [
            Row(
              children: [
                /// Display the user name who is logged in
                Text('${user?.displayName}'),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.arrowRightFromBracket,size: 15.0,color: Colors.redAccent,
                  ),
                  onPressed: () =>
                      BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationExited(),/// log out section
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Center(
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              /// if authentication fails then return to login page
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
                ///if authentication success, go to news page
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
