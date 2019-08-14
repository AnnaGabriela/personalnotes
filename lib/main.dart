import 'package:flutter/material.dart';
import 'package:personalnotes/screens/login.dart';
import 'screens/user_list.dart';
import 'screens/user_page.dart';
import 'utilities/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Notes',
      theme: ThemeData.light()
          .copyWith(appBarTheme: AppBarTheme(color: kMainColor)),
      routes: {
        Login.id: (context) => Login(),
        UserList.id: (context) => UserList(),
        UserPage.id: (context) => UserPage(),
      },
      initialRoute: Login.id,
    );
  }
}
