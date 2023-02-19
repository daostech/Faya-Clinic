import 'package:faya_clinic/api/api_paths.dart';
import 'package:faya_clinic/api/api_service.dart';
import 'package:faya_clinic/models/notification.dart';

abstract class NotificationsRepositoryBase {
  Future<List<NotificationModel>> fetchUserNotifications(String? userId);
  markNotificationsAsRead(List<NotificationModel> notifications);
}

class NotificationsRepository implements NotificationsRepositoryBase {
  final APIService apiService;
  NotificationsRepository(this.apiService);

  @override
  Future<List<NotificationModel>> fetchUserNotifications(String? userId) {
    return apiService.getData<NotificationModel>(
      builder: (data) => NotificationModel.fromJson(data),
      path: APIPath.userNotifications(userId),
    );
  }

  @override
  markNotificationsAsRead(List<NotificationModel> notifications) async {
    notifications.forEach((element) async {
      element.isShowed = true;
      await apiService.putObject(path: APIPath.updateNotification(), body: element.toJson());
    });
  }
}
