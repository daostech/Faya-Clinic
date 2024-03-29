import 'package:faya_clinic/constants/constants.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/screens/user_dates/user_dates_controller.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:faya_clinic/widgets/app_bar_standard.dart';
import 'package:faya_clinic/widgets/item_user_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDatesScreen extends StatelessWidget {
  const UserDatesScreen._({Key? key, required this.controller}) : super(key: key);
  final UserDatesController controller;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final authRepo = Provider.of<AuthRepositoryBase>(context, listen: false);
    return ChangeNotifierProvider<UserDatesController>(
      create: (_) => UserDatesController(
        database: database,
        authRepository: authRepo,
      ),
      builder: (ctx, child) {
        return Consumer<UserDatesController>(
          builder: (context, controller, _) => UserDatesScreen._(controller: controller),
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
                title: TransUtil.trans("header_my_dates"),
              ),
              Container(
                width: double.infinity,
                color: colorPrimary,
              ),
            ],
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (controller.userDates.isEmpty) {
      if (controller.isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );
      return Center(
        child: Text(TransUtil.trans("msg_you_dont_have_dates")),
      );
    }
    final items = controller.userDates;
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (ctx, index) {
        return UserDateItem(
          dateRegistered: items[index],
        );
      },
    );
  }
}
