import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personalnotes/components/person_info.dart';
import 'package:personalnotes/components/colored_button.dart';
import 'package:personalnotes/services/firebase_methods.dart';
import 'package:personalnotes/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
final fireBaseMethods = FirebaseMethods();
bool showSpinner = true;
FirebaseUser loggedInUser;

class UserPage extends StatefulWidget {
  UserPage({this.userInfo});

  final userInfo;
  static String id = 'user';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserPage args = ModalRoute.of(context).settings.arguments;
    final userInfo = args.userInfo;

    Widget addNotes() {
      if (userInfo["title"] != 'student')
        return ColoredButton(text: "Adicionar", onPressed: () {});
      return Container(width: 0, height: 0);
    }

    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Perfil"),
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                }),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                PersonInfo(info: userInfo),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 20.0),
                  child: Text(
                    "NOTAS",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                NotesStream(
                  email: "anna@gmail.com",
                ),
                addNotes(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotesStream extends StatelessWidget {
  NotesStream({@required this.email});

  final String email;

  Future<List<Widget>> getNotes(dynamic notesRef) async {
    final List<Widget> notesWidgets = [];
    for (var doc in notesRef) {
      final text = await doc.get();
      print(text.data["text"]);
      final note = Note(text: "\"oi\"");
      notesWidgets.add(note);
    }
    return notesWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('students')
          .where("email", isEqualTo: email)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final notes = snapshot.data.documents.first;
        final notesRef = notes.data["notes"];
        Widget list = Container(width: 0, height: 0);

        getNotes(notesRef).then((notesWidgets) {
          list = ListView(
            children: [Text("opa")],
          );
        });
        return list;
      },
    );
  }
}

class Note extends StatelessWidget {
  Note({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0), color: Colors.black26),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
        ));
  }
}
