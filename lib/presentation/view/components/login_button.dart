import 'package:flutter/material.dart';
import 'package:sonoflow/presentation/utils/colors.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const LoginButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.goldenYellow),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.midnightBlue),
      ),
    );
  }
}
