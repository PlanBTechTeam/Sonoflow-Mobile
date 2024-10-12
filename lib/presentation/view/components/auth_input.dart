import 'package:flutter/material.dart';

class InputAuth extends StatefulWidget {
  final String hintText;
  final bool password;
  final IconData icon;
  final controller;

  const InputAuth(
      {super.key,
      required this.controller,
      required this.hintText,
      this.password = false,
      required this.icon});

  @override
  State<InputAuth> createState() => _InputAuthState();
}

class _InputAuthState extends State<InputAuth> {
  bool _password = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.2)),
          borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            Icon(widget.icon, color: const Color.fromRGBO(161, 161, 161, 1)),
            const SizedBox(width: 16),
            Expanded(
                child: TextField(
                    controller: widget.controller,
                    obscureText: _password,
                    style: const TextStyle(color: Colors.white), // Cor do texto
                    decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: const TextStyle(
                            color: Color.fromRGBO(161, 161, 161, 0.5)),
                        border: InputBorder
                            .none // Remove a borda padrão do TextField
                        ))),
            if (widget.password == true) ...[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _password = !_password;
                  });
                },
                child: Icon(
                    _password
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    color: Colors.white),
              )
            ]
          ],
        ),
      ),
    );
  }
}
