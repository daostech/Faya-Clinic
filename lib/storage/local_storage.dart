import 'package:faya_clinic/models/storage_model.dart';

abstract class LocalStorageService {
  saveValue(String key, dynamic value);

  getValue(String key, dynamic defaultValue);

  List<StorageModel> getAll();

  insertObject(StorageModel obj);

  updateObject(StorageModel obj);

  insertList(List<StorageModel> list);

  deleteObject(StorageModel obj);

  newObject(StorageModel obj);

  clearAll();
}
