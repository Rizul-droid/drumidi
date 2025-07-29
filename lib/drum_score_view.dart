import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';             // base
import 'package:webview_flutter_android/webview_flutter_android.dart'; // for Android support
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart'; // for iOS support


class DrumScoreView extends StatefulWidget {
  const DrumScoreView({super.key});

  @override
  State<DrumScoreView> createState() => _DrumScoreViewState();
}

class _DrumScoreViewState extends State<DrumScoreView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    PlatformWebViewControllerCreationParams params =
    const PlatformWebViewControllerCreationParams();

    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/html/drum_notation.html');
  }


  Future<void> _sendScore() async {
    final jsonString = await rootBundle.loadString('assets/scores/back_in_black_v2.json');
    final jsCommand = "renderScore(${jsonString.replaceAll("\n", "")});";
    _controller.runJavaScript(jsCommand);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drum Notation')),
      body: WebViewWidget(controller: _controller),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendScore,
        child: const Icon(Icons.send),
      ),
    );
  }
}
