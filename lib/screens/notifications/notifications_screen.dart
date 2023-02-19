import 'package:faya_clinic/providers/notifications_controller.dart';
import 'package:faya_clinic/utils/date_formatter.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/section_corner_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<NotificationsController>();
    return SectionCornerContainer(
      title: TransUtil.trans("header_notifications"),
      child: controller.allNotifications.isEmpty
          ? Center(
              child: Text(TransUtil.trans("msg_no_notifications")),
            )
          : ListView.builder(
              itemCount: controller.allNotifications.length,
              itemBuilder: (ctx, indx) {
                return ListTile(
                  title: Text(controller.allNotifications[indx].title!),
                  subtitle: Text(controller.allNotifications[indx].body!),
                  trailing: Text(MyDateFormatter.notificationDate(controller.allNotifications[indx].creationDate)),
                );
              },
            ),
    );
  }
}
