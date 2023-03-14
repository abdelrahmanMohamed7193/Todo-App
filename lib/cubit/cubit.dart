import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/cubit/states.dart';

class TodoAppCubit extends Cubit<AppStates> {
  TodoAppCubit() : super(AppInitialState());

  static TodoAppCubit get(BuildContext context) => BlocProvider.of(context);
  int currrentIndex = 0;
  int num = 0;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  bool isBottomSheetOpened = false;

  void setIcon() {
    isBottomSheetOpened = !isBottomSheetOpened;
    emit(SetIconState());
  }

  Database? database;

  void setBotNavCurrentIndex(int index) {
    currrentIndex = index;
    emit(SetBotNavCurrentIndexState());
  }

  void createDatabase() async {
    database = await openDatabase(
        'todoApp.db',
        version: 1,
        onCreate: (database, version) {
      print('database created ');
      database.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY , title TEXT,date TEXT ,time TEXT ,status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('error when creating table is ${error.toString()}');
      });
    },
        onOpen: (database) {
      print('database opened ');
      selectFromDatabase(database);
    }) .then((value) {
      database = value;
      emit(CreateDatabaseState());
      return value;
    });
  }

  Future<void> insertIntoDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
     await database!.transaction((txn) {
      return txn
          .rawInsert(
         'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date", "$time", "new")')
          .then((value) {
        print('id is $value');
        emit(InsertIntoDatabaseState());
        selectFromDatabase(database!);
      }).catchError((error) {
        print('error when inserting and error is ${error.toString()}');
      });
    });
  }

  void selectFromDatabase(Database database) {
    database.rawQuery("SELECT * FROM tasks").then((value) {

        newTasks=[]  ;
        doneTasks=[]  ;
        archiveTasks=[]  ;
      value.forEach((element) {
        if(element['status']=='new')
          {
            newTasks.add(element);
          }else if(element['status']=='done'){

          doneTasks.add(element);

        }else{
          archiveTasks.add(element);
        }
       });
      print('newTasks length is ${newTasks.length}');
      print('doneTasks length is ${doneTasks.length}');
      print('archiveTasks length is ${archiveTasks.length}');


      emit(SelectFromDatabaseState());

    });
  }

  void updateToDatabase({String? status, int? id }) {
    database!.rawUpdate(
        "UPDATE tasks SET status= ? WHERE id= ?", ["$status", id ]).then((value) {
      selectFromDatabase(database!);
      emit(UpdateToDatabaseState());
    });
  }
  void deleteFromDatabase(int id) {
    database!.rawDelete(
        "DELETE FROM tasks  WHERE id= ? ", [id]).then((value){
      selectFromDatabase(database!);
      emit(DeleteFromDatabaseState());
    });
  }

}
