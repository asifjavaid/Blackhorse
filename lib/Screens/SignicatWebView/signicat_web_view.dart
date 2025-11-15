import 'package:ekvi/Models/Authentication/create_signicat_session_model.dart';
import 'package:ekvi/Providers/Login/login_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignicatWebView extends StatefulWidget {
  final ScreenArguments arguments;
  const SignicatWebView({super.key, required this.arguments});

  @override
  SignicatWebViewState createState() => SignicatWebViewState();
}

class SignicatWebViewState extends State<SignicatWebView> {
  var provider = Provider.of<LoginProvider>(AppNavigation.currentContext!, listen: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        SizedBox(
          height: 100.h,
          width: 100.w,
        ),
        Positioned(
          top: 40.h,
          child: SizedBox(
              height: 10.h,
              width: 100.w,
              child: const Center(
                child: CircularProgressIndicator(),
              )),
        ),
        Positioned(
          top: 0,
          child: SizedBox(
            height: 80.h,
            width: 100.w,
            child: WebViewWidget(controller: returnController(widget.arguments.webviewData!)),
          ),
        )
      ])),
    );
  }

  WebViewController returnController(CreateSignicatEkviSessionResponse data) => WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color.fromARGB(0, 223, 181, 181))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith(AppConstant.signicatSuccessCallback)) {
            HelperFunctions.showNotification(context, "BankID Authentication successful!");
            provider.handleLoginEkviUser(sessionID: widget.arguments.webviewData!.id!, token: widget.arguments.signicatAccessToken!);

            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(data.authenticationUrl!));
}
