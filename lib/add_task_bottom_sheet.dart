import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatelessWidget {
  String title = '';
  String description = '';
  var fromKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(12),
        child:SingleChildScrollView(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context).textTheme.bodyMedium),
            Form(
              key:fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
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
                      decoration:
                          const InputDecoration(labelText: "Enter Task Title"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
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
                      decoration: const InputDecoration(
                          labelText: "Enter Task description"),
                      maxLines: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.select_date,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('7/8/2024',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Text(AppLocalizations.of(context)!.add,
                          style: Theme.of(context).textTheme.bodyMedium))
                ],
              ),
            )
          ],
        )));
  }
  void addTask(){
    if(fromKey.currentState?.validate()==true){

    }
  }
}
