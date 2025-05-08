import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Needed for Clipboard
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  final String initialUrl;

  const WebViewScreen({super.key, required this.initialUrl});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? _webViewController;

  late String Url;

  @override
  void initState() {
    super.initState();
    Url = widget.initialUrl;
  }

  @override
  Widget build(BuildContext context) {
    print(Url);
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(Url)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
            mediaPlaybackRequiresUserGesture: false,
          ),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
            allowsAirPlayForMediaPlayback: true,
          ),
        ),
        contextMenu: ContextMenu(
          options: ContextMenuOptions(
            hideDefaultSystemContextMenuItems: false,
          ),
          onContextMenuActionItemClicked: (contextMenuItemClicked) async {
            print(
                "Clicked on context menu item: ${contextMenuItemClicked.title}");
            if (contextMenuItemClicked.title.trim() == "paste:") {
              // User clicked "Paste"
              final clipboardData = await Clipboard.getData('text/plain');
              if (clipboardData?.text != null) {
                String jsCode = '''
                  if (document.activeElement && document.activeElement.value !== undefined) {
                    document.activeElement.value += ${jsonEncode(clipboardData!.text)};
                  }
                ''';
                await _webViewController?.evaluateJavascript(source: jsCode);
              }
            }
          },
          onHideContextMenu: () {
            print("Context menu closed");
          },
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;

          _webViewController!.addJavaScriptHandler(
              handlerName: 'handlerFoo',
              callback: (args) {
                return {'bar': 'bar_value', 'baz': 'baz_value'};
              });

          _webViewController!.addJavaScriptHandler(
              handlerName: 'handlerFooWithArgs',
              callback: (args) {
                print(args);
              });
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          final url = navigationAction.request.url.toString();
          setState(() {
            Url = url;
            print("Navigating to: $Url");
          });
          return NavigationActionPolicy.ALLOW;
        },
        onLoadStart: (controller, url) {
          controller.getUrl().then((currentUrl) {
            setState(() {
              Url = currentUrl.toString();
            });
          });
        },
        onUpdateVisitedHistory: (controller, url, androidIsReload) {
          controller.getUrl().then((currentUrl) {
            setState(() {
              Url = currentUrl.toString();
              print("Updated URL: $Url");
            });
          });
        },
        onConsoleMessage: (controller, consoleMessage) {
          print(consoleMessage);
        },
        onLoadStop: (controller, url) async {
          await controller.evaluateJavascript(source: '''
    navigator.mediaDevices.getUserMedia({ video: true, audio: true })
      .then(function(stream) {
        console.log('Camera and microphone permission granted');
        // Stop the stream to release camera
        stream.getTracks().forEach(track => track.stop());
      })
      .catch(function(err) {
        console.error('Permission denied: ', err);
      });
  ''');
        },
        onLoadError: (controller, url, code, message) {
          print("Load error: $code - $message");
        },
      ),
    );
  }
}
