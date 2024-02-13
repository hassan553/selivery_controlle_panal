import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';

class WebPage extends StatefulWidget {
  final String link;
  const WebPage({super.key, required this.link});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  bool isError = false;
  changeError() {
    setState(() {
      isError = true;
    });
  }

  WebViewController? controller;
  giveControllerValue() {
    try {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {
              changeError();
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url
                  .startsWith('https://www.youtube.com/watch?v=snxybJkFeUo')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.link));
    } catch (error) {
      changeError();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    giveControllerValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: isError ? error() : WebViewWidget(controller: controller!),
    );
  }

  Widget error() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppColors.red),
          SizedBox(height: 20),
          Text('يرجاء اعادة المحاوله'),
        ],
      ),
    );
  }
}
