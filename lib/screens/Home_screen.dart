import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/cubit/cubit.dart';
import 'package:todoapp/cubit/states.dart';
import 'package:todoapp/screens/archive_screen.dart';
import 'package:todoapp/screens/done_task_screen.dart';
import 'package:todoapp/screens/new_task_screen.dart';
import '../shared/colors.dart';
import '../shared/component.dart';

class HomeScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  List<Widget> screens = [
    const NewTaskScreen(),
    const DoneTaskScreen(),
    const ArchiveScreen(),
  ];
  List<String> titles = [
    'new task',
    'Done Tasks',
    'Archived tasks',
  ];


  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  IconData icon = Icons.open_in_new;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoAppCubit()..createDatabase(),//كاننا عملنا save لل todoAppCubit في var علشان ن access علي الل جواه
      child: BlocConsumer<TodoAppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          backgroundColor: MyColors.scaffoldBackgroundColor,
          key: scaffoldKey,
          appBar: AppBar(
           backgroundColor:MyColors.appBarColor ,
            title: Center(
                child: Text(titles[TodoAppCubit.get(context).currrentIndex])),
          ),
          body:
          screens[TodoAppCubit.get(context).currrentIndex],
          floatingActionButton: FloatingActionButton(
            backgroundColor: MyColors.FBAbackgroundColor,
            onPressed: () {

      if (TodoAppCubit.get(context).isBottomSheetOpened) {
        if (formKey.currentState!.validate()) {
          TodoAppCubit.get(context).insertIntoDatabase(
            title: titleController.text,
            date: dateController.text,
            time: timeController.text,
          ).then((value) {
            Navigator.pop(context);
            TodoAppCubit.get(context).setIcon();//اعمل insert واقفل وغيرهالي ل false
            icon = Icons.open_in_new;
            print("MyFirstLockedBooleanNow is ${TodoAppCubit.get(context).isBottomSheetOpened}");

          });
        }
      }
              else {
                scaffoldKey.currentState!.showBottomSheet((context) {
                  return Container(

                  color: Color(0x270D55FF),

                    child: Form(
                     key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: defaultFormField(
                              validator:(value){
                                if (value!.isEmpty){
                                  return'this field is required';
                                }
                              },
                              controller: titleController,
                              type: TextInputType.text,
                              prefixIcon: Icons.task,
                              label: "Title",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: defaultFormField(
                              validator:(value){
                                if (value!.isEmpty){
                                  return'this field is required';
                                }

                              } ,
                                controller: dateController,
                                type: TextInputType.number,
                                prefixIcon: Icons.calendar_today,
                                readonly: true,
                                label: "Date",
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse("2022-12-01"),
                                  ).then((value) {
                                    dateController.text = DateFormat.yMMMd().format(value!);
                                    print(dateController.text);
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: defaultFormField(
                                validator:(value){
                                  if (value!.isEmpty){
                                    return'this field is required';
                                  }

                                },
                                controller: timeController,
                                type: TextInputType.datetime,
                                prefixIcon: Icons.watch,
                                label: "Time",
                                readonly: true,
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text = value!.format(context);
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                  );
                }).closed.then((value) {
                  icon=Icons.open_in_new;
                  TodoAppCubit.get(context).isBottomSheetOpened=false;
                  icon=Icons.open_in_new;
                  print("boolean here is ${TodoAppCubit.get(context).isBottomSheetOpened}");
                });
                TodoAppCubit.get(context).setIcon(); //
                icon = Icons.add;
                print("MySecond Opened Boolean Now is ${TodoAppCubit.get(context).isBottomSheetOpened}") ;

      }

              //TodoAppCubit.get(context).insertIntoDatabase();
            },
            child: Icon(icon),
          ),
          bottomNavigationBar: BottomNavigationBar(

            elevation: 600.0,
            unselectedItemColor:MyColors.unSelectedBotNavBarItemColor,
            selectedItemColor: MyColors.selectedBotNavBarItemColor,
            backgroundColor:MyColors.backgroundBotNavBarColor ,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: ' New Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.done_outline),
                label: ' Done Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive),
                label: ' Archive',
              ),
            ],
            currentIndex: TodoAppCubit.get(context).currrentIndex,
            // selectedItemColor:selectedItemColor ,
            onTap: (index) {
              TodoAppCubit.get(context).setBotNavCurrentIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
