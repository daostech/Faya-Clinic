import 'package:faya_clinic/constants/constants.dart';
import 'package:flutter/material.dart';

class MyExpandedTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final List<Widget> children;
  const MyExpandedTile({
    Key key,
    this.children,
    this.iconData,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Icon(
          iconData,
          color: colorPrimary,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: fontSizeStandard,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: children ?? [],
      ),
    );
  }
}
