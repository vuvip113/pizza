import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizza/common/app_colors.dart';
import 'package:pizza/common/ui_helpers.dart';
import 'package:pizza/ui/details/details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/blocs/signin/signin_bloc.dart';
import 'package:pizza/blocs/get_pizza/get_pizza_bloc.dart';

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
      body: BlocBuilder<GetPizzaBloc, GetPizzaState>(
        builder: (context, state) {
          if (state is GetPizzaSuccess) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 9 / 16,
              ),
              itemCount: state.pizzas.length,
              itemBuilder: (context, int i) {
                return Material(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(13),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  Details(state.pizzas[i])));
                    },
                    child: Column(
                      children: [
                        Image.network(state.pizzas[i].picture),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: state.pizzas[i].isVeg
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: Text(
                                    state.pizzas[i].isVeg ? "VEG" : "NON-VEG",
                                    style: const TextStyle(
                                      color: greyLightHover,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              dw,
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: Text(
                                    state.pizzas[i].spicy == 1
                                        ? "🌶️ BLAND"
                                        : state.pizzas[i].spicy == 2
                                            ? "🌶️ BLANDCE"
                                            : "🌶️ SPICY",
                                    style: TextStyle(
                                        color: state.pizzas[i].spicy == 1
                                            ? Colors.green
                                            : state.pizzas[i].spicy == 2
                                                ? Colors.orange
                                                : Colors.redAccent,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            state.pizzas[i].name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            state.pizzas[i].description,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "\$${state.pizzas[i].price - (state.pizzas[i].price * (state.pizzas[i].discount / 100))}.00",
                                      style: TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "\$${state.pizzas[i].price}.00",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w700,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        CupertinoIcons.add_circled_solid))
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is GetPizzaLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("Somgthing Wrong 404"),
            );
          }
        },
      ),
    );
  }
}
