import 'package:dars_66/controllers/praduc_controllers.dart';
import 'package:dars_66/controllers/test_controller.dart';
import 'package:dars_66/firebase_options.dart';
import 'package:dars_66/views/screens/home_screeens.dart';
import 'package:dars_66/views/screens/login_screen.dart';
import 'package:dars_66/views/screens/test_home.dart';
import 'package:dars_66/views/screens/test_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        // return PraductControllers();
        return TestControllers();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        // home: TestHome(),
        // home: LoginScreen(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return const TestHome();
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
