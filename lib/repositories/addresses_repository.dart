import 'package:faya_clinic/models/address.dart';
import 'package:faya_clinic/storage/local_storage.dart';

abstract class AddressesRepositoryBase {
  List<Address> get allAddresses;
  addAddress(Address address);
  deleteAddress(Address address);
  saveAddressesList(List<Address> addresses);
  deleteAll();
}

class AddressesRepository implements AddressesRepositoryBase {
  final LocalStorageService localStorage;
  AddressesRepository(this.localStorage);

  @override
  List<Address> get allAddresses => List<Address>.from(localStorage.getAll()) ?? [];

  @override
  addAddress(Address address) {
    print("AddressesRepository: adding ${address.toJson()}");
    localStorage.insertObject(address);
  }

  @override
  deleteAll() {
    localStorage.clearAll();
  }

  @override
  deleteAddress(Address address) {
    print("AddressesRepository: deleting ${address.toJson()}");
    localStorage.deleteObject(address);
  }

  @override
  saveAddressesList(List<Address> addresses) {
    localStorage.insertList(addresses);
  }
}
