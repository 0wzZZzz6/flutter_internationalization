import 'package:flutter/material.dart';
import 'package:flutter_internationalization/i18n/appLanguage.dart';
import 'package:flutter_internationalization/i18n/appLocalizations.dart';
import 'package:flutter_internationalization/settings.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppLanguage appLanguage = AppLanguage();
  Locale locale = Locale('en');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLang();
    print('didchange');
  }

  getLang() async {
    await appLanguage.fetchLocale();
    print(appLanguage.appLocal);
    setState(() {
      locale = appLanguage.appLocal;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build - $locale');
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('title')),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => Get.to(SettingsPage()))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('Message'),
                style: TextStyle(fontSize: 32),
              ),
              Text(locale.languageCode)
            ],
          ),
        ));
  }
}
