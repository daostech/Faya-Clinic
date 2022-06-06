import 'package:faya_clinic/models/notification.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/repositories/notification_repository.dart';
import 'package:flutter/material.dart';

class NotificationsController with ChangeNotifier {
  static const TAG = "NotificationsController: ";
  final NotificationsRepositoryBase notificationsRepository;

  final AuthRepositoryBase authRepository;
  NotificationsController({this.notificationsRepository, this.authRepository}) {
    // listenForNewNotifications();
  }

  bool _isLoading = true;
  String _error = "";
  int _unReadCount = 0;
  List<NotificationModel> _allNotifications = <NotificationModel>[];

  List<NotificationModel> get allNotifications => _allNotifications;
  bool get isLoading => _isLoading;

  int get unReadNotificationsCount => _unReadCount;

  // listenForNewNotifications() {
  //   print("$TAG test called");
  //   notificationsRepository.getNotificationsList(authRepository.userId).listen((event) {
  //     final newData = event.docs.map((e) => NotificationModel.fromJson(e.data())).toList();
  //     // newData.sort((b, a) => a.creationDate.compareTo(b.creationDate));
  //     handleNewNotifications(newData);
  //     updateWith(allNotifications: newData, unReadCount: getUnReadCount(newData));
  //   });
  // }

  // handleNewNotifications(List<NotificationModel> notifications) async {
  //   print("$TAG handleNewNotifications called");

  //   for (NotificationModel notification in notifications) {
  //     if (!notification.isShowed) {
  //       print("$TAG handleNewNotifications !notification.isShowed ");
  //       NotificationService.showNotification(
  //         title: notification.title,
  //         body: notification.body,
  //         payload: notification.typeId,
  //       );
  //     }
  //   }
  // }
  fetchNotifications() async {
    print("$TAG fetchNotifications called");
    updateWith(loading: true);
    final notifications =
        await notificationsRepository.fetchUserNotifications(authRepository.userId).catchError((error) {
      updateWith(loading: false, error: error.toString());
    });
    // sort the notifications from the older to the newer
    notifications.sort((b, a) => a.creationDate.compareTo(b.creationDate));
    _allNotifications.addAll(notifications);

    updateWith(loading: false, allNotifications: _allNotifications, unReadCount: _calculateUnread);
  }

  // onNotificationsScreenOpened() {
  //   print("$TAG onNotificationsScreenOpened called");
  //   // wait for 3 seconds then update the status of the notifications
  //   Future.delayed(Duration(seconds: 3)).then((value) {
  //     notificationsRepository.markNotificationsAsRead(authRepository.userId);
  //   });
  // }

  onNotificationsScreenOpened() async {
    // todo mark all notifications as read
    print("$TAG onNotificationsScreenOpened called");
    notificationsRepository.markNotificationsAsRead(_allNotifications);
    _allNotifications.forEach((element) {
      element.isShowed = true;
    });
    updateWith(loading: false, unReadCount: _calculateUnread);
  }

  int get _calculateUnread {
    if (_allNotifications == null || _allNotifications.isEmpty) return 0;
    var count = 0;
    _allNotifications.forEach((element) {
      if (!element.isShowed) {
        count++;
      }
    });
    return count;
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
