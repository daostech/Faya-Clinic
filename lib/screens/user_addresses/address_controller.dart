import 'package:faya_clinic/models/address.dart';
import 'package:faya_clinic/repositories/addresses_repository.dart';
import 'package:flutter/material.dart';

class UserAddressesController with ChangeNotifier {
  final AddressesRepositoryBase addressesRepository;
  UserAddressesController({this.addressesRepository}) {
    _userAddresses.clear();
    _userAddresses.addAll(addressesRepository.allAddresses);
  }

  final formKey = GlobalKey<FormState>();
  final List<Address> _userAddresses = [];

  var label = "";
  var country = "";
  var city = "";
  var apartment = "";
  var block = "";
  var streetName = "";
  var zipCode = "";

  List<Address> get userAddresses => _userAddresses;

  bool get hasUpdates =>
      country.isNotEmpty ||
      country.isNotEmpty ||
      country.isNotEmpty ||
      country.isNotEmpty ||
      country.isNotEmpty ||
      country.isNotEmpty;

  Address get address => Address(
        label: label,
        country: country,
        city: city,
        apartment: apartment,
        block: block,
        street: streetName,
        zipCode: int.tryParse(zipCode),
      );

  void submitForm(BuildContext context) {
    if (formKey.currentState.validate()) {
      addressesRepository.addAddress(address);
      _userAddresses.clear();
      _userAddresses.addAll(addressesRepository.allAddresses);
      resetForm();
      notifyListeners();
      Navigator.of(context).pop();
    }
  }

  void deleteAddress(Address address) {
    addressesRepository.deleteAddress(address);
    _userAddresses.clear();
    _userAddresses.addAll(addressesRepository.allAddresses);
    notifyListeners();
  }

  void resetForm() {
    country = "";
    city = "";
    apartment = "";
    block = "";
    streetName = "";
    zipCode = "";
  }
}
