import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify_app/firebase_options.dart';
import 'package:shopify_app/models/category.model.dart';
import 'package:shopify_app/pages/splash_page.dart';
import 'package:shopify_app/providers/adsProvider.dart';
import 'package:shopify_app/providers/app_auth.provider.dart';
import 'package:shopify_app/providers/cart.provider.dart';
import 'package:shopify_app/providers/category.provider.dart';
import 'package:shopify_app/providers/home.provider.dart';
import 'package:shopify_app/providers/product.provider.dart';
import 'package:shopify_app/utils/theme.utils.dart';
import 'package:flutter/material.dart' hide Theme;

Future<void> backgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // Store the notification in Firestore collection
  // You can call a function here to store the notification in Firestore
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  var prefrenceInstance = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefrenceInstance);

  var result = GetIt.I.allReadySync();

  if (result == true) {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> prefrences set successfully');
  } else {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Error When Set prefrences');
  }

  // await PrefrencesService.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppAuthProvider()),
    Provider(create: (_) => CategoryProvider()),
    Provider(create: (_) => ProductProvider()),
    Provider(create: (_) => CartProvider()),
    Provider(create: (_) => AdsProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopify Application',
      theme: flutter.Theme.of(context).copyWith(
        colorScheme: flutter.Theme.of(context)
            .colorScheme
            .copyWith(surfaceVariant: Colors.transparent),
      ),
      home: SplashPage(),
    ));
  }
}
