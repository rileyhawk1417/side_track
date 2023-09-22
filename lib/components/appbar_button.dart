import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton(
      {super.key, required this.onPressedFunc, required this.icon});
  final void Function() onPressedFunc;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(150),
        child: SizedBox(
          height: 120.0,
          width: 55.0,
          child: MaterialButton(
            onPressed: () => onPressedFunc(),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
