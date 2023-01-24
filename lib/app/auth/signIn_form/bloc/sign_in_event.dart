part of 'sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.emailChanged(String emailStr) = EmailChanged;
  const factory SignInEvent.passwordChanged(String passwordStr) =
      PasswordChanged;
  const factory SignInEvent.registerwithEmailAndPasswordPressed() =
      RegisterwithEmailAndPasswordPressed;
  const factory SignInEvent.signInWithEmailAndPasswordPressed() =
      SignInWithEmailAndPasswordPressed;
  const factory SignInEvent.signInWithGooglePressed() = SignInWithgooglePressed;
}
