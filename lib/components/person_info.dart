import 'package:flutter/material.dart';
import 'package:personalnotes/utilities/constants.dart';

class PersonInfo extends StatelessWidget {
  PersonInfo({this.info});

  final info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: kSecondaryColor,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 90.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: 90.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(info["image"]), fit: BoxFit.fill),
                  ),
                ),
                SizedBox(height: 10.0),
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
