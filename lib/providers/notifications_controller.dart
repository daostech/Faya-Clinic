import 'package:faya_clinic/models/notification.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/repositories/notification_repository.dart';
import 'package:faya_clinic/services/notification_service.dart';
import 'package:flutter/material.dart';

class NotificationsController with ChangeNotifier {
  static const TAG = "NotificationsController: ";
  final NotificationsRepositoryBase notificationsRepository;

  final AuthRepositoryBase authRepository;
  NotificationsController({this.notificationsRepository, this.authRepository}) {
    listenForNewNotifications();
  }

  bool _isLoading = true;
  String _error = "";
  int _unReadCount = 0;
  List<NotificationModel> _allNotifications = <NotificationModel>[];

  List<NotificationModel> get allNotifications => _allNotifications;
  bool get isLoading => _isLoading;

  int get unReadNotificationsCount => _unReadCount;

  listenForNewNotifications() {
    print("$TAG test called");
    notificationsRepository.getNotificationsList(authRepository.userId).listen((event) {
      final newData = event.docs.map((e) => NotificationModel.fromJson(e.data())).toList();
      // newData.sort((b, a) => a.creationDate.compareTo(b.creationDate));
      handleNewNotifications(newData);
      updateWith(allNotifications: newData, unReadCount: getUnReadCount(newData));
    });
  }

  handleNewNotifications(List<NotificationModel> notifications) async {
    print("$TAG handleNewNotifications called");

    for (NotificationModel notification in notifications) {
      if (!notification.isShowed) {
        print("$TAG handleNewNotifications !notification.isShowed ");
        NotificationService.showNotification(
          title: notification.title,
          body: notification.text,
          payload: notification.typeId,
        );
      }
    }
  }

  onNotificationsScreenOpened() {
    print("$TAG onNotificationsScreenOpened called");
    // wait for 3 seconds then update the status of the notifications
    Future.delayed(Duration(seconds: 3)).then((value) {
      notificationsRepository.markNotificationsAsRead2(authRepository.userId);
    });
  }

  int getUnReadCount(List<NotificationModel> notifications) {
    if (notifications == null || notifications.isEmpty) return 0;
    var count = 0;
    notifications.forEach((element) {
      if (!element.isShowed) {
        count++;
      }
    });
    return count;
  }

  updateWith({
    bool loading,
    String error,
    int unReadCount,
    List<NotificationModel> allNotifications,
  }) {
    _isLoading = loading ?? this._isLoading;
    _allNotifications = allNotifications ?? this._allNotifications;
    _error = error ?? this._error;
    _unReadCount = unReadCount ?? this._unReadCount;
    notifyListeners();
  }
}
