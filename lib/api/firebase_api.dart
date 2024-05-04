// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

// class FirebaseApi {
//   static final _db = FirebaseDatabase.instance;
//   // static final _db = FirebaseDatabase.instanceFor(
//   //     app: Firebase.apps.first, databaseURL: "https://faya-clinic-app-default-rtdb.firebaseio.com/");
//   static Stream<DatabaseEvent> get chatMessages {
//     _db.setLoggingEnabled(true);
//     final url = _db.databaseURL;
//     print("url $url");
//     // return _db.ref("chats").orderByChild("date").onChildChanged;
//     return _db.ref("chats").onValue;
//   }
// }
