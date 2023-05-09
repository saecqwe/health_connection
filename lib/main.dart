import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_connection/components/globle_variables.dart';
import 'package:health_connection/presentation/screens/activity_scale_screen.dart/activity_scale_provider.dart';
import 'package:health_connection/presentation/screens/forget_password/forget_password_provider.dart';
import 'package:health_connection/presentation/screens/login/login_provider.dart';
import 'package:health_connection/presentation/screens/onboarding/signup_provider.dart';
import 'package:health_connection/presentation/screens/splash/splash_screen_provider.dart';
import 'package:health_connection/presentation/screens/update_mobile_number/verify_mobile_provider.dart';
import 'package:health_connection/routes/app_pages.dart';
import 'package:health_connection/themes/app_theme.dart';

import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider( 
          create: (context) => VerifyMobileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SplashScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgetPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ActivityScaleProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveWrapper.builder(child,
            maxWidth: 800,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(900, name: DESKTOP),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: appTheme(),
        onGenerateRoute: AppPages.onGenerateRoute,
        initialRoute: Routes.splashScreen,
      ),
    );
  }
}

Future<void> initialDependencies() async {
  await initialFirebsaDependencies();
  await GetStorage.init();
}

Future<void> initialFirebsaDependencies() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA3QCggU5Ytj8_rpstXD25iLktYojAm1KI",
            authDomain: "health-connections-9c27f.firebaseapp.com",
            projectId: "health-connections-9c27f",
            storageBucket: "health-connections-9c27f.appspot.com",
            messagingSenderId: "568354083446",
            appId: "1:568354083446:web:81600542ffbaa124414557",
            measurementId: "G-MTY4R423XM"));

            
  } else {
    await Firebase.initializeApp();
  }
}
