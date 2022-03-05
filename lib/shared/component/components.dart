import 'package:bmi_calculator/shared/component/constants.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color backgroundColor = Colors.white,
        Color labelColor = Colors.black,
        double radius = 0.0,
        Function onPressedFun,
        String labelText,
        bool isUpperCase = true}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: MaterialButton(
          elevation: 5,
          height: 40.0,
          child: Text(
            isUpperCase ? labelText.toUpperCase() : labelText,
            style: TextStyle(
                color: labelColor, fontWeight: FontWeight.w400, fontSize: 25),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          onPressed: onPressedFun),
    );

Widget defaultTextFormField(
        {TextEditingController controller,
        InputDecoration inputDecoration,
        String labelText,
        TextStyle labelStyle,
        IconData prefixIcon,
        Color prefixIconColor,
        Color suffixIconColor,
        OutlineInputBorder focusOutlineInputBorder,
        OutlineInputBorder enableOutlineInputBorder,
        TextStyle inputStyle,
        IconData suffixIcon,
        TextInputType keyboardType,
        Function validator,
        bool isPassword = false,
        Function suffixPressed,
        Function onSubmitted,
        Function onChanged,
        Function onTap,
        bool isClickable = true}) =>
    TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: focusOutlineInputBorder,
          enabledBorder: enableOutlineInputBorder,
          labelText: labelText,
          labelStyle: labelStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: prefixIconColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffixIcon,
                    color: suffixIconColor,
                  ))
              : null,
          contentPadding: EdgeInsets.all(16.0)),
      style: inputStyle,
      obscureText: isPassword ? true : false,
      keyboardType: keyboardType,
      enabled: isClickable,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
    );

Widget buildDefaultTaskCard(
  Map model,
  context,
) =>
    Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
            color: lightCardColor,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    child: Text(
                      "${model["time"]}",
                      style: TextStyle(
                          color: lightColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 18),
                    ),
                    backgroundColor: darkColor,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${model["title"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                            color: darkColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "${model["date"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: lightColorWithOpacity,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  IconButton(
                    icon: Icon(Icons.check_box_outline_blank_outlined),
                    color: icon1StColor,
                    iconSize: 35,
                    onPressed: () {
                      AppCubit.get(context)
                          .updateData(status: "Done", id: model['id']);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.archive_rounded),
                    color: icon2NdColor,
                    iconSize: 35,
                    onPressed: () {
                      AppCubit.get(context)
                          .updateData(status: "Archived", id: model['id']);
                    },
                  )
                ],
              ),
            )),
      ),
    );

AppCubit cubit = AppCubit();

Widget tasksBuilder({
  List<Map> tasks,
  String details,
  IconData icon,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: lightColor,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "$details",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) =>
              buildDefaultTaskCard(tasks[index], context),
          separatorBuilder: (context, index) => Divider(
                height: 2,
                color: Colors.grey.withOpacity(0),
              ),
          itemCount: tasks.length),
    );
