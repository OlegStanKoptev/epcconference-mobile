import 'package:flutter/gestures.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/cubits/login.dart';
import 'package:webrtc_conference/repositories/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/screens/auth/register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/login',
      builder: (_) => this,
    );
  }

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
          child: BlocProvider(
            create: (BuildContext context) =>
                LoginCubit(context.read<AuthenticationRepository>()),
            child: const MyCustomForm(),
          ),
        ), /**/
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        onChanged: () {
          Form.of(primaryFocus!.context!)!.save();
        },
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Container(
              height: 400.0,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/ADSD_logo.png'),
                  ),
                  // Add TextFormFields and ElevatedButton here.
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: 300,
                    height: 80,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.mail,
                          color: Colors.cyan,
                        ),
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.cyan,
                            width: 0.5,
                          ),
                        ),
                      ),
                      onSaved: (String? value) {
                        email = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: 300,
                    height: 80,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.cyan,
                        ),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.cyan,
                            width: 0.5,
                          ),
                        ),
                      ),
                      obscureText: true,
                      onSaved: (String? value) {
                        password = value;
                      },
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: ElevatedButton(
                              onPressed: () {
                                save(() => context
                                    .read<LoginCubit>()
                                    .logInWithEmailAndPassword(
                                        email, password));
                              },
                              child: const Text('Login'),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(0, 164, 212, 1.0),
                                fixedSize: const Size(119, 20),
                              ),
                            ),
                          ),
                          //todo Логику кнопки remember me
                          Container(
                              //padding: EdgeInsets.symmetric(vertical: 10),
                              child: RichText(
                            text: TextSpan(
                                text: 'Remember me?',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('xxx');
                                  }),
                          )),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegScreen()));
                              },
                              child: const Text('Register'),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(0, 164, 212, 1.0),
                                  fixedSize: const Size(119, 20)),
                            ),
                          ),
                          Container(
                              //padding: EdgeInsets.symmetric(vertical: 10),
                              child: RichText(
                            text: TextSpan(
                                text: 'Forget password',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('xxx');
                                  }),
                          )),
                        ],
                      ),

                      //Button for registration
                    ],
                  ),
                ],
              ),
            ))));
  }
}
