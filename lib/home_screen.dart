import 'package:flutter/material.dart';
import 'package:todoappp/add_task_bottom_sheet.dart';
import 'package:todoappp/settings_tab.dart';
import 'package:todoappp/task_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        title: Text(
          selectedIndex == 0 ? AppLocalizations.of(context)!.app_title : AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
bottomNavigationBar: BottomAppBar(
  shape: CircularNotchedRectangle(),
  notchMargin: 8,
  child: BottomNavigationBar(
    currentIndex: selectedIndex,
    onTap: (index) {
      setState(() {
        selectedIndex = index;
      });
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.list, size: 24),  // Adjusted icon size
        label: AppLocalizations.of(context)!.task_list,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings, size: 24),  // Adjusted icon size
        label: AppLocalizations.of(context)!.settings,
      ),
    ],
    selectedLabelStyle: TextStyle(
      fontSize: 12, 
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
    ),
  ),
),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showTaskBottomSheet();
          },
          child: Icon(Icons.add, size: 35)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0 ? TaskListTab() : SettingsTab(),
    );
  }

  void showTaskBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        // side: BorderSide(color: appcolor.primarycolor, width: 2),
      ),
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
}
