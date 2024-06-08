import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final String hint;
  final bool obscuretext;
  final TextEditingController controller;

  const Mytextfield({
    super.key,
    required this.hint,
    required this.obscuretext,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: this.obscuretext,
        controller: this.controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
          fillColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
