import 'package:faya_clinic/models/storage_model.dart';

abstract class LocalStorageService {
  saveValue(String key, dynamic value);

  getValue(String key, dynamic defaultValue);

  List<StorageModel> getAll();

  insertObject(StorageModel obj);

  updateObject(StorageModel obj);

  Future insertList(List<StorageModel>? list);

  Future deleteObject(StorageModel obj);

  newObject(StorageModel obj);

  Future clearAll();
}
