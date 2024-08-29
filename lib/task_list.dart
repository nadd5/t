import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/providers/list_provider.dart';
import 'package:todoappp/task_list_item.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStore();
    }

    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            // Handle date change
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
              ? Center(child: Text('No Added Tasks')) // Center the 'No Tasks Added' text
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      task: listProvider.tasksList[index],
                    );
                  },
                  itemCount: listProvider.tasksList.length,
                ),
        ),
      ],
    );
  }
}
