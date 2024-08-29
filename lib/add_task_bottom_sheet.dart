import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/firebase_utils.dart';
import 'package:todoappp/model/task.dart';
import 'package:todoappp/providers/list_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  String description = '';
  var selectDate = DateTime.now();
  String title = '';
  bool isAdding = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appcolor.whitecolor, 
        borderRadius: BorderRadius.circular(20)
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Please Enter Task Title";
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black, // Set text color to black
                        fontSize: 12, // Set font size to 12
                      ),
                      cursorColor: Colors.blue, // Set the cursor color to blue
                      decoration: InputDecoration(
                        labelText: "Enter Task Title",
                        filled: true,
                        fillColor: Colors.transparent, // Making text field background transparent
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Blue underline for text field
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Blue underline when focused
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: TextFormField(
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Please Enter Task Description";
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black, // Set text color to black
                        fontSize: 12, // Set font size to 12
                      ),
                      cursorColor: Colors.blue, // Set the cursor color to blue
                      decoration: InputDecoration(
                        labelText: "Enter Task Description",
                        filled: true,
                        fillColor: Colors.transparent, // Making text field background transparent
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Blue underline for text field
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Blue underline when focused
                        ),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.select_date,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(height: 4), // Reduced space between label and date
                          InkWell(
                            onTap: showCalendar,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: appcolor.whitecolor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                '${selectDate.day}/${selectDate.month}/${selectDate.year}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        if (!isAdding) addTask();
                      },
                      backgroundColor: appcolor.primarycolor,
                      child: Icon(
                        isAdding ? Icons.check : Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      setState(() {
        isAdding = true;
      });

      Task task = Task(
        dateTime: selectDate,
        title: title,
        description: description,
      );

      FirebaseUtils.addTaskToFirebase(task).then((value) {
        Provider.of<ListProvider>(context, listen: false)
            .getAllTasksFromFireStore();
        setState(() {
          isAdding = false;
        });
        Navigator.pop(context);
      });
    }
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onSurface: appcolor.primarycolor,
            ),
            dialogBackgroundColor: appcolor.whitecolor,
          ),
          child: child!,
        );
      },
    );
    if (chosenDate != null) {
      setState(() {
        selectDate = chosenDate;
      });
    }
  }
}
