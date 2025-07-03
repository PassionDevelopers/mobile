import 'dart:async';

import 'package:could_be/core/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late StreamSubscription fireSubscription;

  @override
  void initState(){
    super.initState();

    fireSubscription = FirebaseAuth.instance.userChanges().listen((User? event) {
      if (event == null) {
        context.go(RouteNames.login);
      }else{
        if (FirebaseAuth.instance.currentUser == null) {
          context.go(RouteNames.login);
        } else {
          context.go(RouteNames.login);
        }
      }
    });
  }

  @override
  void dispose(){
    fireSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
