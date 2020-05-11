import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sss_mobile/screens/login_screen.dart';

import 'networking/custom_proxy.dart';
import 'string.dart';

void main() async {
  if (!kReleaseMode) {
    // For Android devices you can also allowBadCertificates: true below, but you should ONLY do this when !kReleaseMode
    final proxy = CustomProxy(ipAddress: "localhost", port: 8888);
    proxy.enable();
  }

  // Run app
  runApp(SSSApp());
}

class SSSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: Strings.appTitle,
        home: new LoginForm()
    );
  }

}