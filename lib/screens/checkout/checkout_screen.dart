import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/providers/checkout_controller.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _controller = context.watch<CheckoutController>();

    Widget _buildTabItem(int index, String title, bool selected) {
      return InkWell(
        onTap: () => _controller.currentTabIndex = index,
        child: Container(
          width: size.width * 0.25,
          padding: const EdgeInsets.all(marginLarge),
          color: selected ? Colors.white : colorPrimary,
          child: Center(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected ? colorPrimary : Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Column(
            // app bar + tabs container
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarStandard(
                title: "Checkout",
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
                child: Row(
                  children: [
                    _buildTabItem(0, TransUtil.trans("tab_address"), _controller.currentTabIndex == 0),
                    _buildTabItem(1, TransUtil.trans("tab_shipping"), _controller.currentTabIndex == 1),
                    _buildTabItem(2, TransUtil.trans("tab_review"), _controller.currentTabIndex == 2),
                    _buildTabItem(3, TransUtil.trans("tab_payment"), _controller.currentTabIndex == 3),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: _controller.currentTab,
          ),
        ],
      ),
    );
  }
}
