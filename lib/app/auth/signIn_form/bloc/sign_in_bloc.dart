import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:to_do_list/domain/auth/auth_failure.dart';
import 'package:to_do_list/domain/auth/i_auth_facade.dart';
import 'package:to_do_list/domain/auth/value_objects.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(super.initialState, this._authFacade);
  final IAuthFacade _authFacade;

  SignInState get initialState => SignInState.initial();

  @override
  // TODO: implement stream
  Stream<SignInState> mapEventsToState(
    SignInEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (value) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(value.emailStr),
          authFaliureOrSucces: none(),
        );
      },
      passwordChanged: (value) async* {
        yield state.copyWith(
          password: Password(value.passwordStr),
          authFaliureOrSucces: none(),
        );
      },
      registerwithEmailAndPasswordPressed: (value) async* {
        final emailIsValid = state.emailAddress.isValid();
        final passwordIsValid = state.password.isValid();
        if (emailIsValid && passwordIsValid) {
          yield state.copyWith(
            isSubmitting: true,
            authFaliureOrSucces: none(),
          );
          final failureOrSuccess =
              await _authFacade.registerWithEmailAndPassword(
            emailAddress: state.emailAddress,
            password: state.password,
          );
          yield state.copyWith(
            isSubmitting: false,
            authFaliureOrSucces: some(failureOrSuccess),
          );
        }
        yield state.copyWith(
          showErrorMessage: true,
          authFaliureOrSucces: none(),
        );
      },
      signInWithEmailAndPasswordPressed: (value) async* {
        final emailIsValid = state.emailAddress.isValid();
        final passwordIsValid = state.password.isValid();
        if (emailIsValid && passwordIsValid) {
          yield state.copyWith(
            isSubmitting: true,
            authFaliureOrSucces: none(),
          );
          final failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
            emailAddress: state.emailAddress,
            password: state.password,
          );
          yield state.copyWith(
            isSubmitting: false,
            authFaliureOrSucces: some(failureOrSuccess),
          );
        }
        yield state.copyWith(
          showErrorMessage: true,
          authFaliureOrSucces: none(),
        );
      },
      signInWithGooglePressed: (value) async* {
        yield state.copyWith(
          isSubmitting: true,
          authFaliureOrSucces: none(),
        );
        final failureOrSucces = await _authFacade.signInWithGoogle();
        yield state.copyWith(
          isSubmitting: false,
          authFaliureOrSucces: some(failureOrSucces),
        );
      },
    );
  }
}
