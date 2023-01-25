import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do_list/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:to_do_list/domain/auth/i_auth_facade.dart';
import 'package:to_do_list/domain/auth/value_objects.dart';
import 'package:to_do_list/domain/core/errors.dart';

class FirebaseIAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseIAuthFacade(
    this._firebaseAuth,
    this._googleSignIn,
  );

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressSrt = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressSrt,
        password: passwordStr,
      );
      return right(unit);
    } on PlatformException catch (error) {
      if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return left(AuthFailure.emailAlreadyInUse());
      } else {
        return left(AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressSrt = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressSrt,
        password: passwordStr,
      );
      return right(unit);
    } on PlatformException catch (error) {
      if (error.code == 'ERROR_WRONG_PASSWORD' ||
          error.code == 'ERROR_USER_NOT_FOUND') {
        return left(AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(AuthFailure.cancelledByUser());
      }
      final googleAuthentication = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );
      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then((value) => right(unit));
    } on PlatformException catch (error) {
      return left(const AuthFailure.serverError());
    }
  }
}
