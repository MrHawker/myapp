import 'package:flutter/material.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/routes.dart';
import 'package:myapp/services/firestore.dart';
import 'package:myapp/services/models.dart';
import 'package:myapp/shared/bottom_nav.dart';
import 'package:myapp/theme.dart';
import 'package:provider/provider.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}



class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {


  final Future<FirebaseApp> _initialization = Firebase.initializeApp().catchError((error)=> print(error));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return  Text('${snapshot.error}',textDirection: TextDirection.ltr);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider(
            create: (_) => FirestoreService().streamReport(),
            catchError: (_,err) => Report(),
            initialData: Report(),
            child: MaterialApp(
              routes: appRoutes,
              theme: appTheme,
              
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text("loading",textDirection: TextDirection.ltr,);
      },
    );
  }
}