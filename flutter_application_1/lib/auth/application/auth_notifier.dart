

import 'package:flutter_application_1/auth/infrastructure/github_authenticator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../infrastructure/domain/auth_failure.dart';

part 'auth_notifier.freezed.dart';
@freezed
class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initial() =_Initial;
  const factory AuthState.unauthenticated()= _Unauthenticated;
  const factory AuthState.authenticated()= _Authenticated;
  const factory AuthState.failure(AuthFailure failure)= _Failure;
  }

  class AuthNotifier extends StateNotifier<AuthState> {
    final GithubAuthenticator _authenticator;
    AuthNotifier(this._authenticator) : super(const AuthState.initial());

    Future<void> checkAndUpdateAuthStatus() async {
      state = (await _authenticator.isSignedIn()) 
      ? const AuthState.unauthenticated()
      : const AuthState.unauthenticated();
    }
  }