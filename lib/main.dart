import 'package:flowlink/screens/profile_screen.dart';
import 'package:flowlink/screens/signup.dart';
import 'package:flowlink/screens/signup_details.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/onboarding_screen2.dart';
import 'screens/onboarding_screen3.dart';
import 'screens/login_screen.dart';
import 'screens/settings.dart';
import 'screens/forgot_password.dart';
import 'screens/change_password.dart';
import 'screens/security_screen.dart';
import 'screens/email_password_login.dart';
import 'screens/home_screen.dart';
import 'screens/location_screen.dart';
import 'screens/choose_location_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding1': (context) => const OnboardingScreen(),
        '/onboarding2': (context) => const OnboardingScreen2(),
        '/onboarding3': (context) => const OnboardingScreen3(),
        '/signup': (context) => const SignupPage(),
        '/signup_details': (context) => const SignupDetailsPage(),
        '/login_screen': (context) => const LoginScreen(),
        '/setting': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/change_password': (context) => const ChangePasswordScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/security': (context) => const SecurityScreen(),
        '/email_password_login': (context) => const EmailPasswordLoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/location': (context) => const LocationScreen(),
        '/choose_location': (context) => const ChooseLocationScreen(),
      },
    );
  }
}