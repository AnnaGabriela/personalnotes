import 'package:flutter/material.dart';
import 'package:personalnotes/screens/user_page.dart';
import 'package:personalnotes/utilities/constants.dart';
import 'package:personalnotes/components/colored_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personalnotes/screens/user_list.dart';
import 'package:personalnotes/services/firebase_methods.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  static String id = 'login';

  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final firebaseMethods = FirebaseMethods();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String titleValue = 'Aluno';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 110.0),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset('images/logo.png'),
                        height: 90.0,
                      ),
                    ],
                  ),
                  Text('Personal Notes', style: kTitleTextStyle),
                  SizedBox(height: 30.0),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => email = value,
                    decoration: kTextInputDecoration.copyWith(
                        hintText: 'Enter your email'),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    obscureText: true,
                    onChanged: (value) => password = value,
                    decoration: kTextInputDecoration.copyWith(
                        hintText: 'Enter your password'),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButton(
                    isExpanded: true,
                    value: titleValue,
                    onChanged: (String newValue) {
                      setState(() => titleValue = newValue);
                    },
                    items: <String>['Aluno', 'Instituição']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ColoredButton(
                    text: 'Log In',
                    onPressed: () async {
                      setState(() => showSpinner = true);
                      try {
                        final user = _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          final userInfo = await firebaseMethods.getUserInfo(
                              user, titleValue, email);
                          if (userInfo != null) {
                            if (titleValue == 'Aluno') {
                              Navigator.pushNamed(context, UserPage.id,
                                  arguments: UserPage(userInfo: userInfo));
                            } else {
                              Navigator.pushNamed(context, UserList.id,
                                  arguments: UserList(userTitle: titleValue));
                            }
                            setState(() => showSpinner = false);
                          } else {
                            setState(() => showSpinner = false);
                            print("Usuário ou senha inválidos!");
                          }
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
