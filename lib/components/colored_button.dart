import 'package:flutter/material.dart';
import 'package:personalnotes/utilities/constants.dart';

class ColoredButton extends StatelessWidget {
  ColoredButton({this.text, this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            padding: EdgeInsets.all(15.0),
            color: kMainColor,
            child: Text(text, style: TextStyle(color: Colors.white)),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
