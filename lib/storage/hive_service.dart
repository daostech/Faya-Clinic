import 'package:faya_clinic/models/storage_model.dart';
import 'package:faya_clinic/storage/local_storage.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class HiveLocalStorageService implements LocalStorageService {
  Box box;
  String boxName;

  HiveLocalStorageService(String _boxName) {
    this.boxName = _boxName;
    box = Hive.box(boxName);
  }

  @override
  saveValue(String key, dynamic value) {
    box.put(key, value);
  }

  @override
  getValue(String key, dynamic defaultValue) {
    var item = box.get(key, defaultValue: defaultValue);
    return item;
  }

  @override
  insertObject(StorageModel obj) {
    box.put(obj.primaryKey, obj);
  }

  @override
  deleteObject(StorageModel obj) {
    if (obj.isInBox) obj.delete();
    box.delete(obj.primaryKey);
  }

  @override
  insertList(List<StorageModel> list) {
    list.forEach((element) {
      insertObject(element);
    });
  }

  @override
  updateObject(StorageModel obj) {
    if (obj.isInBox) obj.save();
  }

  @override
  List<StorageModel> getAll() {
    return List<StorageModel>.from(box.values);
  }

  @override
  newObject(StorageModel obj) {
    box.put(Uuid().v4(), obj);
  }

  @override
  clearAll() {
    box.clear();
  }
}
