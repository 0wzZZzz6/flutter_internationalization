import 'package:flutter/material.dart';
import 'package:flutter_internationalization/i18n/appLanguage.dart';
import 'package:flutter_internationalization/myHomePage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'i18n/appLocalizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return GetMaterialApp(
          locale: model.appLocal,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('th', 'TH'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: MyHomePage(),
        );
      }),
    );
  }
}
