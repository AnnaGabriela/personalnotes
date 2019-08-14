import 'package:flutter/material.dart';
import 'package:personalnotes/utilities/constants.dart';

class Note extends StatelessWidget {
  Note({this.info});

  final info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: kSecondaryColor,
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Column(
              children: <Widget>[
                Text("${info["name"]}",
                    textAlign: TextAlign.center, style: kTitleStyle),
                Text("${info["description"]}",
                    textAlign: TextAlign.center, style: kDescriptionStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
