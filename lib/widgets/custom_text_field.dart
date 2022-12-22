import 'package:flutter/material.dart';

Widget customTextField(controller) {
  return TextField(
    textAlign: TextAlign.end,
    decoration: const InputDecoration(
      fillColor: Colors.grey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),
    controller: controller,
  );
}
