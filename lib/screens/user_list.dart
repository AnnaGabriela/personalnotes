import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser loggedInUser;

class UserList extends StatefulWidget {
  UserList({this.userTitle});

  final userTitle;
  static String id = 'list';

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final UserList args = ModalRoute.of(context).settings.arguments;

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.userTitle),
        ),
      ),
    );
  }
}
