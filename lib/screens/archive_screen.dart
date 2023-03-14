import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cubit/cubit.dart';
import 'package:todoapp/cubit/states.dart';
import 'package:todoapp/shared/component.dart';


class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoAppCubit,AppStates>(
      listener: (context, state){},
      builder:(context, state)=>Container(
        width: double.infinity,
        padding:const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Expanded(
              child: ListView.separated(
                itemBuilder:(context, index)=>ArchivetaskItem(TodoAppCubit.get(context).archiveTasks[index], context)  ,
                separatorBuilder:(context, index)=> const Divider(thickness:2.0 ,
                color: Colors.black,),
                itemCount: TodoAppCubit.get(context).archiveTasks.length,
              ),
            )
          ],
        ),
      ),


    );
  }
}
