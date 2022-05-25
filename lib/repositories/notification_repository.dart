import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NotificationsRepositoryBase {
  Future markNotificationsAsRead2(String userId);
  Stream<QuerySnapshot<Map<String, dynamic>>> getNotificationsList(String userId);
}

class NotificationsRepository implements NotificationsRepositoryBase {
  static const _COLLECTION_NAME = 'UserNotifcation';
  static const _FIELD_NAME = 'UserId';

  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getNotificationsList(String userId) {
    return _firestore.collection(_COLLECTION_NAME).where(_FIELD_NAME, isEqualTo: userId).snapshots();
    // _firestore.collection("UserNotifications").where("UserId", isEqualTo: userId).snapshots().listen((event) {
    //   print("NotificationsRepository getNotificationsList called ");
    //   return event.docChanges.toList().map((e) => NotificationModel.fromJson(e.doc.data())).toList();
    // });
  }

  @override
  Future markNotificationsAsRead2(String userId) async {
    final snapshots = await _firestore.collection(_COLLECTION_NAME).where(_FIELD_NAME, isEqualTo: userId).get();
    for (QueryDocumentSnapshot snapshot in snapshots.docs) {
      final newData = {"IsOpen": true};
      _firestore.collection(_COLLECTION_NAME).doc(snapshot.id).update(newData);
    }
    // for(NotificationModel model in userNotifications){
    //   _firestore.collection("UserNotifcation").doc(model.id)
    // }
    // event.docChanges.toList().map((e) => NotificationModel.fromJson(e.doc.data())).toList();
  }
}
