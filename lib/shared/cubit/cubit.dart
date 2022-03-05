import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/modules/archived_tasks/archived_tasks.dart';
import 'package:bmi_calculator/modules/done_tasks/done_tasks.dart';
import 'package:bmi_calculator/modules/new_tasks/new_tasks.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  // create object from BlocProvider
  static AppCubit get(context) => BlocProvider.of(context);
  int bottomIndex = 0;
  List<Widget> screens = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List titles = ["New Tasks", "Done Tasks", "Archived Tasks"];

  void changeBottomIndex(int index) {
    bottomIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database database;
  // List<Map> tasks = [];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertToDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });

      return null;
    });
  }

  void updateData({
    @required String status,
    @required int id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataInDatabaseState());
    });
  }

  void deleteData({
    @required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataInDatabaseState());
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetDataFromDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'Done')
          doneTasks.add(element);
        else
          archiveTasks.add(element);
        print(element['status']);
      });
      emit(AppGetDataFromDatabaseState());
    });
  }


  bool isBottomSheetOpened = false;
  IconData fabIcon = Icons.edit;


  void changeBottomSheetState(
      {@required bool isShow, @required IconData icon}) {
    isBottomSheetOpened = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
