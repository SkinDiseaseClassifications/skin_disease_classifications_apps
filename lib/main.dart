import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:skin_disease_classifications/localization.dart';
import 'package:skin_disease_classifications/theme.dart';
import 'package:skin_disease_classifications/ui/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('id', AppLocale.ID),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

// the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(
      ThemeData.light()
          .textTheme, // Anda bisa menyesuaikan dengan TextTheme Anda sendiri
    );
    return MaterialApp(
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      darkTheme: materialTheme.light(),
      title: 'Skin Disease Classification',
      home: HomePage(),
    );
  }
}
