import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreensShow extends StatefulWidget {
  final String url;
  WebViewScreensShow({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewScreensShow> createState() => _WebViewScreensShowState();
}

class _WebViewScreensShowState extends State<WebViewScreensShow> {
  // late InAppWebViewController _webViewController;
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
        ),
        if (loadingPercentage < 100)
          Center(
            child: CircularProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
          ),
      ],
    );
    // return InAppWebView(
    //     initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
    //     initialOptions: InAppWebViewGroupOptions(
    //       crossPlatform: InAppWebViewOptions(
    //         mediaPlaybackRequiresUserGesture: false,
    //         // debuggingEnabled: true,
    //       ),
    //     ),
    //     onWebViewCreated: (InAppWebViewController controller) {
    //       _webViewController = controller;
    //     },
    //     androidOnPermissionRequest: (InAppWebViewController controller,
    //         String origin, List<String> resources) async {
    //       return PermissionRequestResponse(
    //           resources: resources,
    //           action: PermissionRequestResponseAction.GRANT);
    //     });
  }
}
