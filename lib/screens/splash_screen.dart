import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:singage_player/screens/select_url.dart';
import 'package:singage_player/screens/webview.dart';
import 'package:singage_player/widgets/splash_logo.dart';
import 'package:singage_player/widgets/splash_title.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final serverUrl = prefs.getString('server_url');

    if (serverUrl != null && serverUrl.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WebViewScreen(initialUrl: serverUrl),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SelectServerScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SplashLogo(),
            SizedBox(height: 10),
            SplashTitle(),
          ],
        ),
      ),
    );
  }
}


// import 'dart:async';

// import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:singage_player/screens/select_url.dart';
// import 'package:singage_player/screens/webview.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateAfterDelay();
//   }

//   Future<void> _navigateAfterDelay() async {
//     await Future.delayed(const Duration(seconds: 2));

//     final prefs = await SharedPreferences.getInstance();
//     final serverUrl = prefs.getString('server_url');

//     if (serverUrl != null && serverUrl.isNotEmpty) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => WebViewScreen(initialUrl: serverUrl),
//         ),
//       );
//     } else {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const SelectServerScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               "assets/image/logo.png",
//               height: 200,
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Signage Player",
//               style: TextStyle(
//                   fontSize: 30, fontWeight: FontWeight.w500, color: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
