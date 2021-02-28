import 'package:flutter/material.dart';

TextStyle customTextStyle() {
  return TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
}

InputDecoration search() {
  return InputDecoration(
      hintText: "Search...",
      hintStyle: TextStyle(color: Colors.grey.shade400),
      prefixIcon: Icon(
        Icons.search,
        color: Colors.grey.shade400,
        size: 20,
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: EdgeInsets.all(8),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey.shade100,
          )
      )
  );
}


