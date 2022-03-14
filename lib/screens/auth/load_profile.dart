
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/cubits/profile.dart';
import 'package:webrtc_conference/repositories/database.dart';

import '../../main.dart';

class LoadProfileScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute(
        '/load_profile',
        builder: (_) => this
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadProfileBody(),
    );
  }
}

class LoadProfileBody extends StatefulWidget {
  @override
  _LoadProfileBodyState createState() => _LoadProfileBodyState();
}

class _LoadProfileBodyState extends State<LoadProfileBody> {
  @override
  void initState() {
    super.initState();
    _run();
  }

  void _run() async {
    await waitCustomUserClaims();
    context.read<DatabaseRepository>().initializeService();
    _load();
  }

  void _load() {
    // final user = getBloc<AuthenticationCubit>(context).state.user;
    // final data = MemberData(
    //   displayName: user.displayName,
    //   imageUrl: user.imageUrl,
    // );
    // load(() => getBloc<ProfileCubit>(context).load(data));
    load(() => context.read<ProfileCubit>().load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (ProfileState previous, ProfileState current) {
        return previous.status != current.status;
      },
      builder: (BuildContext context, ProfileState state) {
        final cases = {
          ProfileStatus.initial: () => Container(),
          ProfileStatus.loading: () =>
              Center(child: CircularProgressIndicator()),
          ProfileStatus.error: () {
            return Center(
                child: FloatingActionButton(
                  onPressed: () {
                    BotToast.cleanAll();
                    _load();
                  },
                  child: Icon(Icons.replay),
                ));
          },
          ProfileStatus.ready: () => Container(),
        };
        assert(cases.length == ProfileStatus.values.length);
        return cases[state.status]!();
      },
    );
  }

  Future<bool> waitCustomUserClaims([int retry = 0]) async {
    if (retry < 4) {
      await Future.delayed(Duration(milliseconds: 100));
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('No access, try again'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    navigator?.pop();
                  },
                  child: Text('OK')
              ),
            ],
          );
        }
      );
      return false;
    }
    // final idTokenResult =
    // await FirebaseAuth.instance.currentUser.getIdTokenResult(true);
    // final customUserClaims =
    // idTokenResult.claims['https://hasura.io/jwt/claims'];
    // if (customUserClaims == null) {
    //   return waitCustomUserClaims(retry + 1);
    // }

    // Get latest token
    // If couldn't, make another request
    return true;
  }
}