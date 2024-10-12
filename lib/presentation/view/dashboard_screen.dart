import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            color: Colors.white,
          ),
          child: const Padding(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Text('DASHBOARD SCREEN'),
            ),
          ),
        ),
      ],
    );
  }
}
