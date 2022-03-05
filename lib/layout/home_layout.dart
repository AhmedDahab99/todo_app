import 'package:bmi_calculator/shared/component/components.dart';
import 'package:bmi_calculator/shared/component/constants.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
        if (state is AppInsertToDatabaseState) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: darkColor,
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: lightColor,
            title: Text(cubit.titles[cubit.bottomIndex],style: TextStyle(
              color: darkColor
            ),),
            centerTitle: true,
          ),
          body: state is AppGetDataFromDatabaseLoadingState
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: cubit.screens[cubit.bottomIndex],
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheetOpened) {
                if (formKey.currentState.validate()) {
                  cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text);
                }
              } else {
                scaffoldKey.currentState
                    .showBottomSheet(
                        (context) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defaultTextFormField(
                                          controller: titleController,
                                          labelText: "Task Title",
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black45),
                                          inputStyle: TextStyle(
                                              color: Colors.grey[700]),
                                          prefixIconColor: Colors.black,
                                          keyboardType: TextInputType.text,
                                          prefixIcon: Icons.title_rounded,
                                          focusOutlineInputBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey[700]
                                                  .withOpacity(0.4),
                                            ),
                                          ),
                                          enableOutlineInputBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                            ),
                                          ),
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Please Enter Task Title";
                                            }
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      defaultTextFormField(
                                          controller: dateController,
                                          labelText: "Task Date",
                                          keyboardType: TextInputType.datetime,
                                          prefixIcon:
                                              Icons.calendar_today_rounded,
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black45),
                                          inputStyle: TextStyle(
                                              color: Colors.grey[700]),
                                          prefixIconColor: Colors.black,
                                          focusOutlineInputBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey[700]
                                                  .withOpacity(0.4),
                                            ),
                                          ),
                                          enableOutlineInputBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                            ),
                                          ),
                                          onTap: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate:
                                                        DateTime.utc(2030))
                                                .then((value) {
                                              dateController.text =
                                                  DateFormat.yMMMd()
                                                      .format(value);
                                            });
                                          },
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Please Enter Date";
                                            }
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      defaultTextFormField(
                                          controller: timeController,
                                          labelText: "Task Time",
                                          keyboardType: TextInputType.datetime,
                                          prefixIcon: Icons.access_time_rounded,
                                          focusOutlineInputBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey[700]
                                                  .withOpacity(0.4),
                                            ),
                                          ),
                                          enableOutlineInputBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                            ),
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black45),
                                          inputStyle: TextStyle(
                                              color: Colors.grey[700]),
                                          prefixIconColor: Colors.black,
                                          onTap: () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now())
                                                .then((value) {
                                              timeController.text = value
                                                  .format(context)
                                                  .toString();
                                            });
                                          },
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Please Enter Time";
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        elevation: 20)
                    .closed
                    .then((value) {
                  titleController.clear();
                  dateController.clear();
                  timeController.clear();
                  cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                }).catchError((onError) {
                  print(onError.toString());
                });
                cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
              }
            },
            backgroundColor: lightColor,
            foregroundColor: darkColor,
            tooltip: "Add New Task",
            child: Icon(
              cubit.fabIcon,
              size: 32,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: lightColor,
            elevation: 100,
            fixedColor: darkColor,
            unselectedItemColor: darkColorWithOpacity,
            unselectedLabelStyle: TextStyle(color: darkColorWithOpacity),
            currentIndex: cubit.bottomIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.changeBottomIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.tasks), label: "Tasks"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done_all_outlined), label: "DONE"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_rounded), label: "Archived"),
            ],
          ),
        );
      }),
    );
  }
}
// 1.create db then create tables
// 2.open db
// 3.insert
// 4.get
// 5.update
// 6.delete
