import 'package:flutter/material.dart';
import 'package:myapp/services/firestore.dart';
import 'package:myapp/services/models.dart';
import 'package:myapp/shared/bottom_nav.dart';
import 'package:myapp/shared/ErrorMessage.dart';
import 'package:myapp/shared/loading.dart';
import 'topic_items.dart';
import 'drawer.dart';
class TopicScreen extends StatelessWidget {
  const TopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return FutureBuilder<List<Topic>> (
      future: FirestoreService().getTopic(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const LoadingScreen();
        } else if (snapshot.hasError){
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if  (snapshot.hasData){
          var topics = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurpleAccent,
              title: const Text('Topics'),
            ),
            drawer: TopicDrawer(topics:topics),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics found in database');
        }
      });
  }
}