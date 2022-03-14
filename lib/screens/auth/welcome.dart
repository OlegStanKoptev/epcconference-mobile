import 'package:webrtc_conference/common/route.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart';
import 'package:webrtc_conference/screens/auth/login.dart';

import '../../main.dart';

class WelcomeScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/welcome',
      builder: (_) => this,
    );
  }

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Svg('assets/images/Login_Background.svg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: const EnterForm()
        ),
      ),
    );
  }
}

class EnterForm extends StatelessWidget {
  const EnterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Container(
                  height: 400.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Image.asset('assets/images/ADSD_logo.png'),
                      ),
                      // Add ElevatedButton here.
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            navigator?.push(LoginScreen().getRoute());
                          },
                          child: const Text('Enter'),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 164, 212, 1.0),
                            fixedSize: const Size(120, 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
