import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/firebase_utils.dart';
import 'package:todoappp/model/task.dart';
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
          initialDate: listProvider.selectedDate,
          onDateChange: (selectedDate) {
            listProvider.changeSelectedDate(selectedDate);
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
          child: StreamBuilder(
            stream: FirebaseUtils.getTasksCollection()
                .where('dateTime', isGreaterThanOrEqualTo: listProvider.selectedDate)
                .where('dateTime', isLessThan: listProvider.selectedDate.add(Duration(days: 1)))
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error loading tasks'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No Tasks Added'));
              }

              var tasks = snapshot.data!.docs.map((doc) => doc.data() as Task).toList();

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  var task = tasks[index];
                  return TaskListItem(task: task);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
