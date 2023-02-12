import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loginandregister_flutter/Screens/Home.dart';
import 'package:loginandregister_flutter/Screens/Login.dart';
import 'package:loginandregister_flutter/Screens/MainScreen.dart';
import 'package:loginandregister_flutter/providers/app_state.dart';
import 'package:loginandregister_flutter/providers/auth_provider.dart';
import 'package:loginandregister_flutter/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'di_container.dart' as di;
import 'Screens/locators/service_locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  setupLocator();
  LocationPermission permission;
  permission = await Geolocator.requestPermission();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateProvider>.value(
          value: AppStateProvider(),
        ),
        ChangeNotifierProvider<UserProvider>.value(
          value: UserProvider.initialize(),
        ),
        ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
        // ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserProvider auth = Provider.of<UserProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(411, 823),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Golf Cart',
        home: MyHomePage(
          title: 'Golf Cart',
        ),
      ),
    );
  }
}
