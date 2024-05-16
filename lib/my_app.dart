import 'package:flutter/material.dart';
import 'package:pizza/ui/home/home.dart';
import 'package:pizza/common/app_colors.dart';
import 'package:pizza/ui/welcome/welcome.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/blocs/signin/signin_bloc.dart';
import 'package:pizza/blocs/authentication_bloc/authentication_bloc.dart';

class MyAppPizza extends StatelessWidget {
  const MyAppPizza({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pizza Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
          colorScheme: const ColorScheme.light(
            surface: kcVeryLightGrey,
            onSurface: kcDarkGreyColor,
            primary: orangeNormal,
            onPrimary: orangeLight,
          ),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SignInBloc(
                        context.read<AuthenticationBloc>().userRepository),
                  ),
                ],
                child: const Home(),
              );
            } else {
              return const WelcomeScreen();
            }
          }),
        ));
  }
}
