import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    "New tasks",
    "Done tasks",
    "Archived tasks",
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarStates());
  }

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  late Database database;
  void CreatDatabase() {
    openDatabase(
      'dataAAb.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT , data TEXT , time TEXT ,status TEXT )')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Table is error ${error.toString()}');
        });
      },
      onOpen: (database) {
        getdatafromdatabase(database);
        print('Opened database');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  inserToDatabase({
    required String title,
    required String data,
    required String time,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title ,data,time,status) VALUES("$title" ,"$data","$time","new")')
          .then((value) {
        print('$value inserted successful');
        emit(AppInsertDatabaseState());

        getdatafromdatabase(database);
      }).catchError((error) {
        print('date inserted error is ${error.toString()}');
      });
    });
  }

  void getdatafromdatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element["status"] == "new") {
          newTasks.add(element);
        } else if (element["status"] == "done") {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }

        ;
      });
      emit(AppGetDatabaseState());
    });
    ;
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ["$status", id]).then((value) {
      getdatafromdatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getdatafromdatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  IconData fabIcon = Icons.mode_rounded;
  bool isBottomSheetShow = false;
  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShow = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetStates());
  }

  
}
