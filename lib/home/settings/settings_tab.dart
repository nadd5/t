import 'package:flutter/material.dart';
import 'package:todoappp/appcolor.dart';
import 'package:todoappp/home/settings/language_bottom_sheet.dart';
import 'package:todoappp/home/settings/theme_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.language, style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: appcolor.whitecolor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: appcolor.primarycolor, width: 2),
            ),
            child: InkWell(
              onTap: () {
                showLanguageSheet(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.english,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text(AppLocalizations.of(context)!.mode, style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: appcolor.whitecolor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: appcolor.primarycolor, width: 2),
            ),
            child: InkWell(
              onTap: () {
                showThemeBottomSheet(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.light,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

void showLanguageSheet(BuildContext context) {
  showCustomBottomSheet(context, const LanguageBottomSheet());
}

void showThemeBottomSheet(BuildContext context) {
  showCustomBottomSheet(context, const ThemeBottomSheet());
}

void showCustomBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: appcolor.primarycolor, width: 2),
    ),
    context: context,
    builder: (context) => child,
  );
}
}
