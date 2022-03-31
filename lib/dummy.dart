import 'package:faya_clinic/constants/config.dart';
import 'package:faya_clinic/models/address.dart';
import 'package:faya_clinic/models/date_registered.dart';
import 'package:faya_clinic/models/payment_method.dart';
import 'package:faya_clinic/models/product.dart';
import 'package:faya_clinic/models/shipping_method.dart';

class DummyData {
  static List<ShippingMethod> shippingMethods = [
    ShippingMethod(id: "1", method: "Free Shipping", price: 0.0, unite: "${AppConfig.PREFFERED_QURRENCY_UNIT}"),
    ShippingMethod(id: "2", method: "Flat Rate", price: 10.0, unite: "${AppConfig.PREFFERED_QURRENCY_UNIT}"),
    ShippingMethod(id: "3", method: "Local pickup", price: 20.0, unite: "${AppConfig.PREFFERED_QURRENCY_UNIT}"),
  ];

  static List<PaymentMethod> paymentMethods = [
    PaymentMethod(id: "1", method: "Direct bank transfer", image: ""),
    PaymentMethod(id: "2", method: "Cash on delivery", image: ""),
    PaymentMethod(id: "3", method: "Credit/Bank card", image: ""),
    // PaymentMethod(id: "1", method: "Razorpay", image: ""),
    // PaymentMethod(id: "1", method: "stripe", image: ""),
  ];

  static List<DateRegistered> fakeReservedDates = [
    DateRegistered(id: "", userId: "", time: "10:00"),
    DateRegistered(id: "", userId: "", time: "11:00"),
    DateRegistered(id: "", userId: "", time: "12:00"),
    DateRegistered(id: "", userId: "", time: "13:00"),
    DateRegistered(id: "", userId: "", time: "14:00"),
    DateRegistered(id: "", userId: "", time: "15:00"),
  ];

  static List<Address> userAddresses = [
    Address(
      id: "1",
      label: "Address 1",
      city: "city",
      country: "country",
      zipCode: 33000,
      street: "street",
      apartment: "apartment",
      block: "block",
    ),
    Address(
      id: "2",
      label: "Address 2",
      city: "city2",
      country: "country2",
      zipCode: 33000,
      street: "street2",
      apartment: "apartment2",
      block: "block2",
    ),
    Address(
      id: "3",
      label: "Address 3",
      city: "city3",
      country: "country3",
      zipCode: 33000,
      street: "street3",
      apartment: "apartment3",
      block: "block3",
    ),
  ];
  static List<Product> latestProducts = [
    Product(
      id: "1",
      name: "Product 1",
      // price: 19.99,
      img1: "",
      price: 19,
    ),
    Product(
      id: "2",
      name: "Product 2",
      // price: 33.99,
      img1: "",
      price: 33,
    ),
    Product(
      id: "3",
      name: "Product 3",
      // price: 55.00,
      img1: "",
      price: 55,
    ),
    Product(
      id: "4",
      name: "Product 4",
      // price: 90.14,
      img1: "",
      price: 90,
    ),
    Product(
      id: "5",
      name: "Product 5",
      img1: "",
      price: 22,
    ),
    Product(
      id: "6",
      name: "Product 6",
      img1: "",
      price: 34,
    ),
    Product(
      id: "7",
      name: "Product 7",
      img1: "",
      price: 67,
    ),
  ];
}
