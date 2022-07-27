import 'package:authentication_with_bloc/authenticaiton/bloc/authentication_bloc.dart';
import 'package:authentication_with_bloc/authenticaiton/data/providers/authentication_firebase_provider.dart';
import 'package:authentication_with_bloc/authenticaiton/data/providers/google_sign_in_provider.dart';
import 'package:authentication_with_bloc/authenticaiton/data/repositories/authenticaiton_repository.dart';
import 'package:authentication_with_bloc/home/repository/home_repository.dart';
import 'package:authentication_with_bloc/home/views/home_main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Bloc.observer = AppBlocObserver();
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
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
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
