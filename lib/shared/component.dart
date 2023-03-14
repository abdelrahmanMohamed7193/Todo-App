import 'package:flutter/material.dart';

import '../cubit/cubit.dart';
Widget defaultFormField(
    {
      required TextEditingController controller ,
      required TextInputType type ,
      required IconData prefixIcon ,
      required String label ,

      void Function()? onTap ,
      String? Function(String?)? validator ,
       String? validateText ,
      void Function(String)? onChanged ,
      IconData? suffixIcon ,
      void Function()? suffixPressed ,

      bool enabled =true ,
      bool readonly=false ,
      bool isPassword=false ,
    }
    ) =>Padding(
  padding: const EdgeInsets.all(0.0),
  child:   TextFormField (
    controller: controller,
    onTap:onTap,

    decoration:InputDecoration(
      enabled: enabled,
      label:Text(label) ,
      prefixIcon:Icon(prefixIcon)  ,

      suffixIcon:IconButton(
        onPressed:suffixPressed,
        icon: Icon(suffixIcon),

      ) ,

      border: const OutlineInputBorder() ,
    ) ,
    readOnly:readonly ,
   validator:validator,
    obscureText:isPassword,
    onChanged:onChanged,
  ),
) ;


Widget taskItem(Map item,BuildContext context )=>Dismissible(
background:Container(color:Colors.deepPurple , ),
  key: Key("${item["id"]}") ,

  onDismissed: (direction)
  {

TodoAppCubit.get(context).deleteFromDatabase(item["id"]);

  },
  child:   Row(
  
    children:  [
  
       CircleAvatar(
  
        radius: 40.0,
  
  backgroundColor: Colors.black,
  
   child: Text(item['time']),
  
      ),
  
     const SizedBox(width:30,) ,
  
   Column(
  
     crossAxisAlignment: CrossAxisAlignment.start,
  
      children:  [
  
      Text(item['title'] ,
  
      style:const TextStyle(
  
        fontSize: 15,
  
        fontWeight: FontWeight.bold,
  
        color: Colors.white,
  
      )
  
      ),
      const SizedBox(height: 4.0,) ,
  
      Text(item["date"] ,
  
      style:const TextStyle(
  
        fontSize: 15,
  
        fontWeight: FontWeight.bold,
  
        color: Colors.grey,
  
      )
  
      ),
  
  
  
     ],
  
   ),
  
  
  
      const Spacer(),
  
      IconButton(
 color: Colors.white,
        highlightColor: Colors.white,

        onPressed: (){
  
  TodoAppCubit.get(context).updateToDatabase(status:"done" ,id :item['id'] );
  
  
  
        } ,
  
        icon:const Icon(Icons.done_outline),
  
      ),
  
      IconButton(
        color: Colors.white,
        onPressed: (){
  
        TodoAppCubit.get(context).updateToDatabase(status:"archive" ,id: item["id"]);
  
  
  
      } , icon:const Icon(Icons.archive),)
  
    ],
  
  ),
);
Widget donetaskItem(Map item,BuildContext context )=>Dismissible(
background:Container(color:Colors.deepPurple , ),
  key: Key("${item["id"]}") ,
  onDismissed: (direction)
  {

TodoAppCubit.get(context).deleteFromDatabase(item["id"]);

  },
  child:   Row(

    children:  [

       CircleAvatar(

        radius: 40.0,

  backgroundColor: Colors.black,

   child: Text(item['time']),

      ),

     const SizedBox(width:30,) ,

   Column(

     crossAxisAlignment: CrossAxisAlignment.start,

      children:  [

      Text(item['title'] ,

      style:const TextStyle(

        fontSize: 15,

        fontWeight: FontWeight.bold,

        color: Colors.white,

      )

      ),

        const SizedBox(height: 4.0,) ,

      Text(item["date"] ,

      style:const TextStyle(

        fontSize: 15,

        fontWeight: FontWeight.bold,

        color: Colors.grey,

      )

      ),



     ],

   ),



      const Spacer(),

      IconButton(
        color: Colors.white,
        onPressed: (){

        TodoAppCubit.get(context).updateToDatabase(status:"archive" ,id: item["id"]);



      } , icon:const Icon(Icons.archive),)

    ],

  ),
);

Widget ArchivetaskItem(Map item,BuildContext context )=>Dismissible(
background:Container(color:Colors.deepPurple , ),
  key: Key("${item["id"]}") ,
  onDismissed: (direction)
  {

TodoAppCubit.get(context).deleteFromDatabase(item["id"]);

  },
  child:   Row(

    children:  [

       CircleAvatar(

        radius: 40.0,

  backgroundColor: Colors.black,

   child: Text(item['time']),

      ),

     const SizedBox(width:30,) ,

   Column(

     crossAxisAlignment: CrossAxisAlignment.start,

      children:  [

      Text(item['title'] ,

      style:const TextStyle(

        fontSize: 15,

        fontWeight: FontWeight.bold,

        color: Colors.white,

      )

      ),

      Text(item["date"] ,

      style:const TextStyle(

        fontSize: 15,

        fontWeight: FontWeight.bold,

        color: Colors.grey,

      )

      ),

     ],
   ),

      const Spacer(),

      IconButton(
color: Colors.white,
        onPressed: (){

  TodoAppCubit.get(context).updateToDatabase(status:"done" ,id :item['id'] );



        } ,

        icon:const Icon(Icons.done_outline),

      ),



    ],

  ),
);


