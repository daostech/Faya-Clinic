import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/user_orders/user_order_details_screen.dart';
import 'package:faya_clinic/screens/user_orders/user_orders_controller.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/item_previous_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserOrdersScreen extends StatelessWidget {
  const UserOrdersScreen._({Key key, @required this.controller}) : super(key: key);
  final UserOrderController controller;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final authRepo = Provider.of<AuthRepositoryBase>(context, listen: false);
    return ChangeNotifierProvider<UserOrderController>(
      create: (_) => UserOrderController(
        database: database,
        authRepository: authRepo,
      ),
      builder: (ctx, child) {
        return Consumer<UserOrderController>(
          builder: (context, controller, _) => UserOrdersScreen._(controller: controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            // app bar container
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarStandard(
                title: TransUtil.trans("header_previous_orders"),
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
              ),
            ],
          ),
          Expanded(child: _buildContent(context)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (controller.userOrders.isEmpty) {
      if (controller.isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );
      return Center(
        child: Text(TransUtil.trans("msg_you_dont_have_orders")),
      );
    }
    final items = controller.userOrders;
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (ctx, index) {
        return PreviousOrderItem(
          order: items[index],
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (builder) => UserOrderDetailsScreen(
                order: items[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
