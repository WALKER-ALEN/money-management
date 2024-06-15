import 'package:flutter/material.dart';

void showSnackBar(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('your expense added successfully'),duration: Duration(seconds: 3), ));
}