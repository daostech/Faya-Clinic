import 'package:faya_clinic/models/notification.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/repositories/notification_repository.dart';
import 'package:flutter/material.dart';

class NotificationsController with ChangeNotifier {
  static const TAG = "NotificationsController: ";
  final NotificationsRepositoryBase notificationsRepository;
  final AuthRepositoryBase authRepository;
  NotificationsController({this.notificationsRepository, this.authRepository}) {
    fetchNotifications();
  }

  bool _isLoading = true;
  String _error = "";
  int _unReadCount = 0;
  List<NotificationModel> _allNotifications = <NotificationModel>[];

  List<NotificationModel> get allNotifications => _allNotifications;
  bool get isLoading => _isLoading;

  int get unReadNotificationsCount => _unReadCount;

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
    // _allNotifications.add(NotificationModel(
    //   title: "Title test",
    //   text: "text",
    //   isShowed: false,
    //   creationDate: DateTime.now(),
    // ));
    // _allNotifications.add(NotificationModel(
    //   title: "Title test",
    //   text: "text",
    //   isShowed: false,
    //   creationDate: DateTime.now().subtract(Duration(days: 1)),
    // ));
    // _allNotifications.add(NotificationModel(
    //   title: "Title test",
    //   text: "text",
    //   isShowed: false,
    //   creationDate: DateTime(2022, 3, 1),
    // ));
    updateWith(loading: false, allNotifications: _allNotifications, unReadCount: _calculateUnread);
  }

  onNotificationsScreenOpened() async {
    // todo mark all notifications as read
    print("$TAG onNotificationsScreenOpened called");
    // notificationsRepository.markNotificationsAsRead(_allNotifications);
    // _allNotifications.forEach((element) {
    //   element.isShowed = true;
    // });
    // updateWith(loading: false, unReadCount: _calculateUnread);
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
