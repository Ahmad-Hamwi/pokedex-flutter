import 'package:flutter/material.dart';

class LayoutNoMoreData extends StatelessWidget {
  const LayoutNoMoreData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: const Text(
        "No more data",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
