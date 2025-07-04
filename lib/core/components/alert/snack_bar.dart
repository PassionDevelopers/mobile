
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String msg}){
  if(context.mounted){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}