import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoappp/appcolor.dart';

class TaskListItem extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.all(12),
      child:Slidable(
  // The start action pane is the one at the left or the top side.
  startActionPane: ActionPane(
    extentRatio:0.25,
    // A motion is a widget used to control how the pane animates.
    motion: const DrawerMotion(),
    children: [
      // A SlidableAction can have an icon and/or a label.
      SlidableAction(
        borderRadius: BorderRadius.circular(15),
        onPressed: (context){

        },
        backgroundColor: appcolor.redcolor,
        foregroundColor: appcolor.whitecolor,
        icon: Icons.delete,
        label: 'Delete',
      ),
    ],
  ),
      child: Container(
      padding:EdgeInsets.all(12),
      decoration:BoxDecoration(
        color: appcolor.whitecolor,
        borderRadius: BorderRadius.circular(25),
      ),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          margin:EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height*0.1,
          width:4,
          color: appcolor.primarycolor,

        ),
        Expanded(child:
        Container(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            Text('Title',
            style:Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: appcolor.primarycolor)),
            Text("Description",
            style:Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: appcolor.primarycolor)),
          ]
        ),
        ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal:12),
          decoration:
          BoxDecoration(
          borderRadius:BorderRadius.circular(15),
          color: appcolor.primarycolor,
         ),
      child: IconButton(
        onPressed:(){},
      icon:Icon(Icons.check,size:35),
      color:appcolor.whitecolor
      ))
      ],
      ),
    )));
  }
}