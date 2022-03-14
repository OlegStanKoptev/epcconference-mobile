import 'dart:async';

import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';

import 'helpers.dart';

class NoServerFound implements Exception {
  @override String toString() => "Bad host url";
}

class MessageUp implements Exception {
  MessageUp({required this.message});
  final String message;
  @override String toString() => message;
}

class RepeatableMessageUp implements RepeatableAction {
  RepeatableMessageUp({required this.message});
  final String message;
  @override String toString() => message;
}

class BadCredentials implements Exception {
  @override String toString() => "Wrong credentials";
}
class BadResponseCode implements RepeatableAction {
  BadResponseCode({required this.statusCode});
  final int statusCode;
  @override String toString() => "Bad response code: $statusCode";
}

class EmailPasswordAuth {
  static EmailPasswordAuth instance = EmailPasswordAuth._();

  EmailPasswordAuth._();

  StreamController<User?> logStatusStreamController = () {
    var controller = StreamController<User?>();
    controller.add(null);
    return controller;
  }();

  Stream<User?> authStateChanges() {
    return logStatusStreamController.stream;
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    var host = Uri.parse('http://localhost:5000/auth/login');
    Response r = await post(
        host,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userName': email,
          'password': password
        }),
    );

    if (r.statusCode == 200) {
      var token = r.body;
      if (token[0] == '"') token = token.substring(1);
      if (token[token.length-1] == '"') token = token.substring(0, token.length-1);
      if (!token.startsWith('Basic ')) { token = 'Basic $token'; }
      logStatusStreamController.add(User(email: email, token: token));
    } else if (r.statusCode == 500) { // supposed to be 401
      throw BadCredentials();
    } else {
      throw BadResponseCode(statusCode: r.statusCode);
    }
  }

  Future<void> signUpWithBasicData(BasicUserData userData, String password) async {
    var credentials = {
      'name': userData.name,
      'email': userData.email,
      'country': userData.country,
      'password': password
    };

    var host = Uri.parse('to-be-replaced');
    Response r = await post(host, body: credentials);

    print(r.statusCode);
    print(r);

    if (r.statusCode == 200) {
      var body = r.body;
      throw MessageUp(message: body);
    } else if (r.statusCode == 401) {
      throw BadCredentials();
    } else {
      throw BadResponseCode(statusCode: r.statusCode);
    }
  }

  Future<void> signOut() async {
    logStatusStreamController.add(null);
  }
}

class EmailPasswordAuthMock extends EmailPasswordAuth {
  static EmailPasswordAuthMock instance = EmailPasswordAuthMock._();

  EmailPasswordAuthMock._(): super._();

  Future<void> signInWithEmailPassword(String email, String password) async {
    var generator = Random();
    if (generator.nextBool()) {
      logStatusStreamController.add(User(email: email, token: 'token'));
    } else if (generator.nextBool()) {
      throw BadCredentials();
    } else {
      throw BadResponseCode(statusCode: 999);
    }
  }

  Future<void> signUpWithBasicData(BasicUserData userData, String password) async {
    var generator = Random();
    if (generator.nextBool()) {
      throw MessageUp(message: 'body');
    } else if (generator.nextBool()) {
      throw BadCredentials();
    } else {
      throw BadResponseCode(statusCode: 999);
    }
  }
}

class BasicUserData {
  BasicUserData({
    required this.name,
    required this.email,
    required this.country,
  });
  String name;
  String email;
  String country;
}

class User {
  User({this.email, required this.token});
  String? email;
  String token;
}
