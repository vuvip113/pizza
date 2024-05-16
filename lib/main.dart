import 'package:pizza/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:user_repository/user_repository.dart';
import 'package:pizza/services/simple_bloc_observer.dart';
import 'package:pizza/blocs/authentication_bloc/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: const MyAppPizza(),
    );
  }
}
