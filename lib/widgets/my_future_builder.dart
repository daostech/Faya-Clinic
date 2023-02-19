import 'package:flutter/material.dart';

class MyFutureBuilder<T> extends StatelessWidget {
  const MyFutureBuilder({Key? key, required this.future, this.waiting, this.error, this.noData, required this.builder})
      : super(key: key);
  final Future future;
  final Widget? waiting;
  final Widget? error;
  final Widget? noData;
  final Function(T? data) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future.then((value) => value as T),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: waiting ?? CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            print("hasError: ${snapshot.error}");
            return Center(
              child: error ?? Text("Error !"),
            );
          }
          if (!snapshot.hasData) {
            print("hasData: ${snapshot.hasData}");
            return Center(
              child: noData ?? Text("No data !"),
            );
          }
          final items = snapshot.data;
          return builder(items);
        });
  }
}
