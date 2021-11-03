import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/dummy.dart';
import 'package:faya_clinic/screens/add_address_screen.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:flutter/material.dart';

class UserAddresses extends StatelessWidget {
  const UserAddresses({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userAddresses = DummyData.userAddresses;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (builder) => AddAddressScreen())),
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
            child: ListView.separated(
              itemCount: _userAddresses.length,
              padding: const EdgeInsets.all(0),
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(_userAddresses[index].label),
                  subtitle: Text(_userAddresses[index].formatted),
                  trailing: TextButton(
                    onPressed: () {},
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
