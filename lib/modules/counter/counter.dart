import 'package:bmi_calculator/modules/counter/cubit/cubit.dart';
import 'package:bmi_calculator/modules/counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Counter extends StatelessWidget {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      CounterCubit.get(context).addCounter();
                    },
                    icon: Icon(FontAwesomeIcons.plus),
                    iconSize: 60,
                  ),
                  Text(
                    "${CounterCubit.get(context).counter}",
                    style: TextStyle(
                      fontSize: 60,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      CounterCubit.get(context).minusCounter();
                    },
                    icon: Icon(FontAwesomeIcons.minus),
                    iconSize: 60,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
