import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  final WebViewModel web;
  const Web({Key? key, required this.web}) : super(key: key);

  @override
  State<Web> createState() {
    return _WebState();
  }
}

class _WebState extends State<Web> {
  bool _loaded = false;
  bool _callbackSuccess = false;
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(widget.web.javascriptMode)
      ..setUserAgent("random")
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            SVProgressHUD.show();
          },
          onPageFinished: _onPageFinished,
        ),
      )
      ..loadRequest(Uri.parse(widget.web.url));
    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
    SVProgressHUD.show();
  }

  @override
  void dispose() {
    SVProgressHUD.dismiss();
    super.dispose();
  }

  ///Clear Cookie
  Future<void> _clearCookie() async {
    SVProgressHUD.dismiss();
    await _controller?.clearCache();
    await _controller?.clearLocalStorage();
  }

  ///After load page finish
  void _onPageFinished(String url) async {
    if (!mounted) return;
    SVProgressHUD.dismiss();

    ///Show WebView when Completed
    if (!_loaded) {
      setState(() {
        _loaded = true;
      });
    }

    if (!_callbackSuccess) {
      for (var item in widget.web.callbackUrl) {
        if (url.contains(item)) {
          _callbackSuccess = true;
          break;
        }
      }
      if (_callbackSuccess) {
        if (widget.web.clearCookie) {
          await _clearCookie();
        }
        if (!mounted) return;
        Navigator.pop(context, url);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.web.title),
      ),
      body: IndexedStack(
        index: _loaded ? 0 : 1,
        children: [
          WebViewWidget(controller: _controller!),
          Container(color: Theme.of(context).colorScheme.background)
        ],
      ),
    );
  }
}
