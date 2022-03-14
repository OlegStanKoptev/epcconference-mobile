import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:state_persistence/state_persistence.dart';
import 'package:webrtc_conference/common/email_password_auth.dart';
import 'package:webrtc_conference/repositories/authentication.dart';
import 'package:webrtc_conference/screens/home.dart';
import 'package:webrtc_conference/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/screens/auth/welcome.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'cubits/authentication.dart';

// MOCK VARIABLE
final mockServer = true;

final navigatorKey = GlobalKey<NavigatorState>();
NavigatorState? get navigator => navigatorKey.currentState;

late PersistedData? appState;

void main() {
  /*
    Things to do before starting the application
    1. Configure error handler by setting FlutterError.onError
    2. runZonedGuarded<Future<void>> with:
      1) WidgetsFlutterBinding.ensureInitialized()
      2) Configure notifications system
      3) Networking initialization
      4) Locale detection
      5) Storage setup
      6) runApp
   */
  runZonedGuarded(() async {
    // TODO: Support different locale
    await initializeDateFormatting('en_US');
    if (mockServer) {
      runApp(App(
        authenticationRepository: AuthenticationRepository(
            emailPasswordAuth: EmailPasswordAuthMock.instance),
        // databaseRepository: DatabaseRepository(),
      ));
    } else {
      runApp(App(
        authenticationRepository: AuthenticationRepository(),
        // databaseRepository: DatabaseRepository(),
      ));
    }
  }, (error, stackTrace) {
    debugPrint('**** runZonedGuarded ****');
    debugPrint('$error');
    debugPrint('$stackTrace');
  });
}

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    // required this.databaseRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  // final DatabaseRepository databaseRepository;

  @override
  Widget build(BuildContext context) {
    Widget result = const AppView();

    result = BlocProvider(
      create: (BuildContext context) {
        return AuthenticationCubit(authenticationRepository);
      },
      child: result,
    );
    result = RepositoryProvider.value(
      value: authenticationRepository,
      child: result,
    );

    return result;
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget result;

    result = MaterialApp(
      title: 'Conference organizer',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      navigatorObservers: <NavigatorObserver>[
        BotToastNavigatorObserver(),
      ],
      builder: (BuildContext context, Widget? child) {
        Widget result = child!;

        result = BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (BuildContext context, AuthenticationState state) {
            final cases = {
              AuthenticationStatus.authenticated: () {
                navigator?.pushAndRemoveUntil<void>(
                  HomeScreen().getRoute(),
                  (Route route) => false,
                );
              },
              AuthenticationStatus.unauthenticated: () {
                navigator?.pushAndRemoveUntil<void>(
                  const WelcomeScreen().getRoute(),
                  (Route route) => false,
                );
              },
              AuthenticationStatus.unknown: () {},
            };
            assert(cases.length == AuthenticationStatus.values.length);
            cases[state.status]!();
          },
          child: result,
        );

        result = BotToastInit()(context, result);
        if (mockServer) result = result.mockBanner();
        return result;
      },
      onGenerateRoute: (RouteSettings settings) => SplashScreen().getRoute(),
    );

    return result;
  }
}

extension CustomBanner on Widget {
  Widget mockBanner() {
    return Stack(
      children: [
        this,
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: EdgeInsets.only(top: 64, right: 50),
            child: Banner(
              message: "Mock",
              location: BannerLocation.bottomStart,
            ),
          ),
        ),
      ],
    );
  }
}
