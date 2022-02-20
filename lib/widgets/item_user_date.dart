import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/date_registered.dart';
import 'package:flutter/material.dart';

class UserDateItem extends StatelessWidget {
  final DateRegistered dateRegistered;
  const UserDateItem({
    Key key,
    @required this.dateRegistered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // main  container
      margin: const EdgeInsets.all(marginStandard),
      padding: const EdgeInsets.all(marginStandard),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorGreyLight,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusStandard),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1.0, 1.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitle(dateRegistered?.id ?? "id"),
          Row(
            children: [
              Expanded(
                child: Text(""),
              ),
            ],
          ),
          Container(
            // star container
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(radiusStandard),
              ),
            ),
          ),
          Text(
            "Hair removal",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          _subtitle("Candela lazer"),
          _subtitle(dateRegistered?.registeredDate?.toString() ?? "date"),
          _subtitle("11:00 am - 11:30 am"),
        ],
      ),
    );
  }

  Widget _subtitle(String value) {
    return Padding(
      padding: const EdgeInsets.all(marginSmall),
      child: Text(
        value,
        style: TextStyle(
          color: Colors.black54,
          fontSize: fontSizeSmall,
        ),
      ),
    );
  }
}
