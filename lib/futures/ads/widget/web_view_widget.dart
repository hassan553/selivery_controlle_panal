import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/widgets/custom_appBar.dart';

// class WebView extends StatefulWidget {
//   const WebView({super.key});

//   @override
//   State<WebView> createState() => _WebViewState();
// }

// class _WebViewState extends State<WebView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//                 return const WebPage();
//               }));
//             },
//             child: Card(
//               elevation: 10,
//               semanticContainer: true,
//               clipBehavior: Clip.hardEdge,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: SizedBox(
//                   width: 100,
//                   child: Image.asset(
//                     'assets/Screenshot 2023-11-05 224007.png',
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // const CircleAvatar(
//           //   radius: 60,
//           //   backgroundColor: Colors.red,
//           //   backgroundImage:
//           //       AssetImage('assets/Screenshot 2023-11-05 224007.png'),
//           // ),
//           MaterialButton(
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//                 return const WebPage();
//               }));
//             },
//             child: const Text('click'),
//           ),
//         ],
//       )),
//     );
//   }
// }

class WebPage extends StatefulWidget {
  const WebPage({super.key});

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
      ..loadRequest(Uri.parse('https://www.youtube.com/watch?v=csmmD237RtE'));
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
      body: isError
          ? const Center(
              child: Text('error'),
            )
          : WebViewWidget(controller: controller!),
    );
  }
}