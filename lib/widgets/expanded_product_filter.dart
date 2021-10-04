import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';

class ProductExpandedFilter extends StatelessWidget {
  ProductExpandedFilter({
    Key key,
  }) : super(key: key);

  static List dummyVals = [false, true, false, true];

  Widget _buildCheckBoxTile(int index, String title) {
    return CheckboxListTile(
      activeColor: Colors.pink[300],
      dense: true,
      //font change
      title: new Text(
        // checkBoxListTileModel[index].title,
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
      // value: checkBoxListTileModel[index].isCheck,
      value: dummyVals[index]
      // secondary: Container(
      //   height: 50,
      //   width: 50,
      //   child: Text("secondary"),
      // ),
      ,
      onChanged: (bool val) {
        dummyVals[index] = val;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Icon(
          Icons.filter_alt_outlined,
          color: primaryColor,
        ),
        title: Text(
          TransUtil.trans("label_filter"),
          style: TextStyle(
            fontSize: fontSizeStandard,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          _buildCheckBoxTile(0, "category 1"),
          _buildCheckBoxTile(1, "category 2"),
          _buildCheckBoxTile(2, "category 3"),
          _buildCheckBoxTile(3, "category 4"),
        ],
      ),
    );
  }
}
