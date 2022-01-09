import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/repositories/addresses_repository.dart';
import 'package:faya_clinic/screens/user_addresses/add_address_screen.dart';
import 'package:faya_clinic/screens/user_addresses/address_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAddressesScreen extends StatelessWidget {
  const UserAddressesScreen._({Key key, @required this.controller}) : super(key: key);
  final UserAddressesController controller;

  static Widget create(BuildContext context) {
    final addressesRepo = Provider.of<AddressesRepositoryBase>(context, listen: false);
    return ChangeNotifierProvider<UserAddressesController>(
      create: (_) => UserAddressesController(addressesRepository: addressesRepo),
      builder: (ctx, child) {
        return Consumer<UserAddressesController>(
          builder: (context, controller, _) => UserAddressesScreen._(controller: controller),
        );
      },
    );
  }

  void openAddAddressScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) => ChangeNotifierProvider.value(
          value: controller,
          child: AddAddressScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _userAddresses = controller.userAddresses;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddAddressScreen(context),
        child: Icon(
          Icons.add,
          color: Colors.black87,
        ),
      ),
      body: Column(
        children: [
          Column(
            // app bar container
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarStandard(
                title: TransUtil.trans("header_my_addresses"),
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
              ),
            ],
          ),
          Expanded(
            child: _userAddresses.isEmpty
                ? Center(
                    child: TextButton(
                      child: Text("You don't have any address yet click to add one"),
                      onPressed: () => openAddAddressScreen(
                        context,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: _userAddresses.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        title: Text(_userAddresses[index].label ?? ""),
                        subtitle: Text(_userAddresses[index].formatted),
                        trailing: TextButton(
                          onPressed: () => controller.deleteAddress(_userAddresses[index]),
                          child: Icon(
                            Icons.delete,
                            color: colorPrimary,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return Divider(
                        thickness: 0.5,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
