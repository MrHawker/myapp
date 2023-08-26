import 'package:flutter/material.dart';
import 'package:myapp/login/login.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/topics/topics.dart';
import 'package:firebase_auth/firebase_auth.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return const Text('loading');
        else if(snapshot.hasError)
          return const Center(child: Text('error'),);
        else if(snapshot.hasData)
          return const TopicScreen();
        else return const LoginScreen();
        
        
      }
    );
  }
}