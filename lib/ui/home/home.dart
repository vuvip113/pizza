import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/blocs/signin/signin_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            Image.asset(
              "assets/img/8.png",
              scale: 14,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "PIZZA TIME",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.cart)),
          IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line)),
        ],
      ),
      body: const Center(
        child: Text("HEllo word"),
      ),
    );
  }
}
