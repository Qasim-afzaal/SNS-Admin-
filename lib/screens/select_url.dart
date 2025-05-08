import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singage_player/screens/webview.dart';
import 'package:singage_player/widgets/app_logo.dart';
import 'package:singage_player/widgets/server_title.dart';
import 'package:singage_player/widgets/server_radio_tile.dart';
import 'package:singage_player/widgets/continue_button.dart';

const String AWS_URL = "https://www.snsplayer.com//";
const String DIGITAL_OCEAN_URL = "https://groupe.snsplayer.com/";

class SelectServerScreen extends StatefulWidget {
  const SelectServerScreen({super.key});

  @override
  State<SelectServerScreen> createState() => _SelectServerScreenState();
}

class _SelectServerScreenState extends State<SelectServerScreen> {
  String? _selectedServer;
  String? _selectedUrl;

  Future<void> _saveServerUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('server_url', url);
  }

  void _onServerSelected(String? server) {
    if (server == null) return;

    final selectedUrl = server == 'aws' ? AWS_URL : DIGITAL_OCEAN_URL;

    setState(() {
      _selectedServer = server;
      _selectedUrl = selectedUrl;
    });

    _saveServerUrl(selectedUrl);
  }

  void _navigateToWebView() {
    if (_selectedUrl == null) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => WebViewScreen(initialUrl: _selectedUrl!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const AppLogo(),
            const SizedBox(height: 20),
            const ServerTitle(),
            const SizedBox(height: 20),
            ServerRadioTile(
              title: "Server 1",
              value: "aws",
              groupValue: _selectedServer,
              onChanged: _onServerSelected,
            ),
            ServerRadioTile(
              title: "Server 2",
              value: "digital_ocean",
              groupValue: _selectedServer,
              onChanged: _onServerSelected,
            ),
            const Spacer(),
            ContinueButton(
              enabled: _selectedUrl != null,
              onPressed: _navigateToWebView,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:singage_player/screens/webview.dart';

// class SelectServerScreen extends StatefulWidget {
//   const SelectServerScreen({super.key});

//   @override
//   State<SelectServerScreen> createState() => _SelectServerScreenState();
// }

// class _SelectServerScreenState extends State<SelectServerScreen> {
//   static const String AWS_URL = "https://www.snsplayer.com//";
//   static const String DIGITAL_OCEAN_URL = "https://groupe.snsplayer.com/";

//   String? _selectedServer;
//   String? _selectedUrl;

//   Future<void> _saveServerUrl(String url) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('server_url', url);
//   }

//   void _onServerSelected(String? server) {
//     if (server == null) return;

//     final selectedUrl = server == 'aws' ? AWS_URL : DIGITAL_OCEAN_URL;

//     setState(() {
//       _selectedServer = server;
//       _selectedUrl = selectedUrl;
//     });

//     _saveServerUrl(selectedUrl);
//   }

//   void _navigateToWebView() {
//     if (_selectedUrl == null) return;

//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => WebViewScreen(initialUrl: _selectedUrl!),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 40),
//             Center(
//               child: Image.asset(
//                 "assets/image/logo.png",
//                 height: 200,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Select Server",
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black),
//               ),
//             ),
//             const SizedBox(height: 20),
//             RadioListTile<String>(
//               title: const Text("Server 1"),
//               value: "aws",
//               groupValue: _selectedServer,
//               onChanged: _onServerSelected,
//             ),
//             RadioListTile<String>(
//               title: const Text("Server 2"),
//               value: "digital_ocean",
//               groupValue: _selectedServer,
//               onChanged: _onServerSelected,
//             ),
//             const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _selectedUrl != null ? _navigateToWebView : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 child: const Text(
//                   "Continue",
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
