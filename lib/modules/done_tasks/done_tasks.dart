import 'package:bmi_calculator/shared/component/components.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoneTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context,state){
          var tasks = AppCubit.get(context).doneTasks;
          AppCubit cubit = AppCubit.get(context);
          return
            tasksBuilder(
                tasks: tasks,
              details: "No Completed Tasks Yet",
              icon: FontAwesomeIcons.checkCircle
            );
        }
    );
  }
}
