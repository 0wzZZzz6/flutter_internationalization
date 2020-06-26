import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internationalization/i18n/appLanguage.dart';
import 'package:flutter_internationalization/i18n/appLocalizations.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppLanguage appLanguage = AppLanguage();
  List<String> lang = [
    "English",
    "Thai",
  ];

  int selectorIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didchange');
    getLang();
  }

  getLang() async {
    await appLanguage.fetchLocale();
    print(appLanguage.appLocal);
    setState(() {
      appLanguage.appLocal == Locale('en')
          ? selectorIndex = 0
          : selectorIndex = 1;
    });
  }

  onItemSelected(AppLanguage appLanguage, int index) {
    index == 0
        ? appLanguage.changeLanguage(Locale('en'))
        : appLanguage.changeLanguage(Locale('th'));
    setState(() {
      selectorIndex = index;
    });
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value);
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  languageSelector(context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          SizedBox(height: 150.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Card(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                                child: DirectSelectList<String>(
                                    values: lang,
                                    defaultItemIndex: selectorIndex,
                                    itemBuilder: (String value) =>
                                        getDropDownMenuItem(value),
                                    focusedItemDecoration: _getDslDecoration(),
                                    onItemSelectedListener:
                                        (item, index, context) {
                                      onItemSelected(appLanguage, index);
                                    }),
                                padding: EdgeInsets.only(left: 12))),
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.unfold_more,
                            color: Colors.black38,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String settings = AppLocalizations.of(context).translate('Settings');
    String locale = AppLocalizations.of(context).currentLocale();

    return Scaffold(
      appBar: AppBar(
        title: Text(settings),
      ),
      body: DirectSelectContainer(
        child: Column(
          children: <Widget>[Text(locale), languageSelector(context)],
        ),
      ),
    );
  }
}
