
import 'package:dpl/provider/chat_provider.dart';
import 'package:dpl/screens/NumberScreen.dart';

import 'package:dpl/screens/contact_screen.dart';
import 'package:dpl/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';

import 'package:provider/provider.dart';

import 'StudentProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => StudentProvider(),
          ),

          ChangeNotifierProvider(
            create: (_) => ChatProvider(),
          ),
        ],
        child: const MyApp(),
      ));
}

final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }
     Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // App opened from terminated state
    final Uri? initialUri = await _appLinks.getInitialLink();

    if (initialUri != null) {
      handleDeepLink(initialUri);
    }
    // App opened from background
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) {
      handleDeepLink(uri);
    });
  }

  void handleDeepLink(Uri uri) {
    print("Deep Link: $uri");

    // https://open.com/home
    // https://open.com/profile
    // https://open.com/product/10

    final segments = uri.pathSegments;

    if (segments.isEmpty) return;

    switch (segments[0]) {
      case 'home':
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
        break;
      case 'profile':
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
        break;
      case 'settings':
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => const SettingsPage()),
        );
        break;

      case 'product':
        if (segments.length > 1) {
          final id = segments[1];
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => ProductPage(productId: id),
            ),
          );
        }
        break;
    }
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
    // home: const SplashPage(),
      home: const NumberScreen(),
    );
  }
}