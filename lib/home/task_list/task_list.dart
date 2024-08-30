import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/providers/list_provider.dart';
import 'package:todoappp/home/task_list/task_list_item.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {

  @override
  void initState() {
    super.initState();
    var listProvider = Provider.of<ListProvider>(context, listen: false);
    listProvider.getAllTasksFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //listProvider.changeSelectDate(selectedDate);
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    appcolor.primarycolor,
                    Color.fromARGB(255, 145, 190, 220),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 1),
        Expanded(
          child: listProvider.tasksList.isEmpty
              ? Center(child: Text('No Tasks Added'))
              : ListView.builder(
                  itemCount: listProvider.tasksList.length,
                  itemBuilder: (context, index) {
                    var task = listProvider.tasksList[index];
                    return TaskListItem(task: task);
                  },
                ),
        ),
      ],
    );
  }
}