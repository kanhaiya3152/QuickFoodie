import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:quick_foodie/provider/auth_provider.dart' as quick_foodie;
import 'package:quick_foodie/screen/splash_screen.dart';
import 'package:quick_foodie/widget/bottom_navigation.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => quick_foodie.AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Instagram clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance
                .authStateChanges(), // check the page is login or not
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                // use has to be authenticate
                if (snapshot.hasData) {
                  return const BottomNavigation();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }

              return const SplashScreen();
            }),
      ),
    );
  }
}
