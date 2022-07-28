import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto_currency/authenticaiton/bloc/authentication_bloc.dart';
import 'package:crypto_currency/constants/constants.dart';
import 'package:crypto_currency/home/repository/home_repository.dart';
import 'package:crypto_currency/home/views/home_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationSuccess) {
                  /// Navigate to Home page
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiRepositoryProvider(
                          child: HomeView(),
                          providers: [
                            RepositoryProvider(
                              create: (context) => HomeRepository(),
                            ),
                          ],
                        ),
                      ));
                } else if (state is AuthenticationFailiure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              buildWhen: (current, next) {
                if (next is AuthenticationSuccess) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state is AuthenticationInitial ||
                    state is AuthenticationFailiure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'CRYPTO PANIC',
                          style: kAppbarStyle,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        OutlinedButton.icon(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                  style: BorderStyle.solid))),
                          onPressed: () =>
                              BlocProvider.of<AuthenticationBloc>(context).add(
                            AuthenticationGoogleStarted(),
                          ),
                          label: Text(
                            'Login with Google',
                            style: kTextStyle,
                          ),
                          icon: FaIcon(
                            FontAwesomeIcons.googlePlusG,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is AuthenticationLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                }
                return Center(
                    child: Text('Undefined state : ${state.runtimeType}'));
              },
            );
          },
        ),
      ),
    );
  }
}
