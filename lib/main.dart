import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authenticaiton/bloc/authentication_bloc.dart';

import 'authenticaiton/providers/authentication_firebase_provider.dart';
import 'authenticaiton/providers/google_sign_in_provider.dart';
import 'authenticaiton/repository/authenticaiton_repository.dart';
import 'home/repository/home_repository.dart';
import 'home/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationRepository: AuthenticationRepository(
          authenticationFirebaseProvider: AuthenticationFirebaseProvider(
            firebaseAuth: FirebaseAuth.instance,
          ),
          googleSignInProvider: GoogleSignInProvider(
            googleSignIn: GoogleSignIn(),
          ),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto Currency',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
        ),
        home: MultiRepositoryProvider(
          child: HomeView(),
          providers: [
            RepositoryProvider(
              create: (context) => HomeRepository(),
            ),
          ],
        ),
      ),
    );
  }
}
