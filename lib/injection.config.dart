// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:to_do_list/app/auth/signIn_form/bloc/sign_in_bloc.dart' as _i7;
import 'package:to_do_list/domain/auth/i_auth_facade.dart' as _i5;
import 'package:to_do_list/infrastructure/auth/firebase_auth_facade.dart'
    as _i6;

import 'infrastructure/core/firebase_injectable_module.dart' as _i8;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<_i5.IAuthFacade>(() => _i6.FirebaseIAuthFacade(
        gh<_i3.FirebaseAuth>(),
        gh<_i4.GoogleSignIn>(),
      ));
  gh.factory<_i7.SignInBloc>(() => _i7.SignInBloc(
        gh<_i7.SignInState>(),
        gh<_i5.IAuthFacade>(),
      ));
  return getIt;
}

class _$FirebaseInjectableModule extends _i8.FirebaseInjectableModule {}
