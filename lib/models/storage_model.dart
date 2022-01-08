import 'package:hive/hive.dart';

abstract class StorageModel extends HiveObject {
  String primaryKey;
  Map<String, dynamic> toJson();
}
