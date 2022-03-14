import 'dart:async';

import 'package:webrtc_conference/models/user.dart';
import 'package:webrtc_conference/repositories/authentication.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(AuthenticationRepository repository)
      : _repository = repository,
        super(const AuthenticationState.unknown()) {
          _userSubscription = repository.user.listen(changeUser);
        }

  final AuthenticationRepository _repository;
  late StreamSubscription<UserModel> _userSubscription;

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    return super.close();
  }

  void changeUser(UserModel user) {
    final result = user == UserModel.empty
        ? const AuthenticationState.unauthenticated()
        : AuthenticationState.authenticated(user);
    emit(result);
  }

  void requestLogout() {
    _repository.logOut();
  }

}

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = UserModel.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(UserModel user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final UserModel user;

  @override
  List<Object> get props => [status, user];
}