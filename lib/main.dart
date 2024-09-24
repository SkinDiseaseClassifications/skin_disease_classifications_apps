import 'package:flutter/material.dart';
import 'package:skin_disease_classifications/theme.dart';
import 'package:skin_disease_classifications/ui/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(
      ThemeData.light()
          .textTheme, // Anda bisa menyesuaikan dengan TextTheme Anda sendiri
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      darkTheme: materialTheme.light(),
      title: 'Skin Disease Classification',
      home: HomePage(),
    );
  }
}
