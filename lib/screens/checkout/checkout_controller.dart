import 'package:faya_clinic/dummy.dart';
import 'package:faya_clinic/models/address.dart';
import 'package:faya_clinic/models/payment_method.dart';
import 'package:faya_clinic/models/shipping_method.dart';
import 'package:faya_clinic/repositories/addresses_repository.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:flutter/material.dart';

class CheckoutController with ChangeNotifier {
  static const TAG = "[CheckoutController] ";
  static const ERR = "[Error] ";

  final Database database;
  final AddressesRepositoryBase addressesRepository;
  final AuthRepositoryBase authRepository;
  CheckoutController({@required this.authRepository, @required this.addressesRepository, @required this.database}) {
    _savedAddresses = addressesRepository.allAddresses;
  }

  final List paymentMethods = DummyData.paymentMethods;
  final List shippingMethods = DummyData.shippingMethods;
  List<Address> _savedAddresses;

  var _currentTabIndex = 0;
  var _addressSaved = false;
  var _reviewSubmitted = false;
  var userAddedNote = "";
  var totalPriceWithTaxes = 0.0;

  Address selectedAddress;
  ShippingMethod _selectedShippingMethod;
  PaymentMethod _selectedPaymentMethod;

  int get currentTabIndex => _currentTabIndex;
  ShippingMethod get selectedShippingMethod => _selectedShippingMethod;
  PaymentMethod get selectedPaymentMethod => _selectedPaymentMethod;
  List<Address> get savedAddresses => _savedAddresses;

  bool isSelectedPayment(int index) => paymentMethods[index] == _selectedPaymentMethod;

  bool isSelectedShippingMethod(int index) => shippingMethods[index] == _selectedShippingMethod;

  bool isSelectedTab(int index) => _currentTabIndex == index;

  bool nextTab() {
    // this flag indicate that the user has manually submitted this step
    // so we can prevent them from going directly to the last step
    // via tab bar from the previous tabs without submitting this step
    // so this step is considered as vailed either by submiting or adding the optional note
    if (currentTabIndex == 2) _reviewSubmitted = true;
    if (isStepValid(_currentTabIndex)) {
      // check if the current index in the range of our taps
      if (_currentTabIndex < 3) {
        // set the review tab as valid step so the user can't
        // directly move to the last step without submitting this step
        _currentTabIndex++;
        updateWith(tabIndex: _currentTabIndex);
        return true;
      } else {
        placeOrder();
      }
    }
    return false;
  }

  void previousTab() {
    if (_currentTabIndex > 0) {
      _currentTabIndex--;
      updateWith(tabIndex: _currentTabIndex);
    }
  }

  void goToTab(int index) {
    if (index == 0) {
      // requested index 0 is available always
      updateWith(tabIndex: index);
    } else {
      // check the previous step of the requested tap if valid
      if (isStepValid(index - 1)) updateWith(tabIndex: index);
    }
  }

  void placeOrder() {
    print("placeOrder called");
    // todo add the order request here
  }

  void onPaymentSelect(PaymentMethod paymentMethod) {
    updateWith(paymentMethod: paymentMethod);
  }

  void onShippingSelect(ShippingMethod shippingMethod, double cartPrice) {
    totalPriceWithTaxes = shippingMethod.price + cartPrice;
    updateWith(shippingMethod: shippingMethod);
  }

  void onAddressSelect(Address address) {
    // save the address data and mark this step as valid
    selectedAddress = address;
    // _addressPicked = true;
    _addressSaved = true;
  }

  bool saveAddress(Address address) {
    // check if the user has saved the current address in this session
    // and prevent them to trigger this function more than once
    if (_addressSaved) return false;
    if (address.label == null) address.label = "${address.apartment}  ${address.block}";
    addressesRepository.addAddress(address);
    updateWith(savedAddresses: addressesRepository.allAddresses);
    _addressSaved = _savedAddresses.contains(address);
    return _addressSaved;
  }

  bool isStepValid(index) {
    switch (index) {
      case 0:
        return selectedAddress != null;
      case 1:
        return _selectedShippingMethod != null;
      case 2:
        return userAddedNote.isNotEmpty || _reviewSubmitted;
      case 3:
        return _selectedPaymentMethod != null;
      default:
        return false;
    }
  }

  void updateWith({
    int tabIndex,
    ShippingMethod shippingMethod,
    PaymentMethod paymentMethod,
    Address address,
    List<Address> savedAddresses,
  }) {
    this._currentTabIndex = tabIndex ?? this._currentTabIndex;
    this._selectedShippingMethod = shippingMethod ?? this._selectedShippingMethod;
    this._selectedPaymentMethod = paymentMethod ?? this._selectedPaymentMethod;
    this._savedAddresses = savedAddresses ?? this._savedAddresses;
    // this._selectedAddress = address ?? this._selectedAddress;
    notifyListeners();
  }
}
