import 'package:faya_clinic/constants/clinic_dates.dart';
import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/models/user_date/user_date.dart';
import 'package:faya_clinic/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class UserDateItem extends StatelessWidget {
  final UserDate dateRegistered;
  const UserDateItem({
    Key key,
    @required this.dateRegistered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clinicTime = ClinicDates.getClinicDateByStartTime(dateRegistered.time);
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
          // _subtitle(dateRegistered?.id ?? "id"),
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
          // section name
          Text(
            dateRegistered.sections?.name ?? "N/A",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          // sub section name
          _subtitle(dateRegistered.sections?.subSections?.first?.name ?? "N/A"),
          _subtitle(MyDateFormatter.toStringDate(dateRegistered?.registeredDate) ?? "date"),
          _subtitle("${clinicTime?.formattedStartEnd12H}"),
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
