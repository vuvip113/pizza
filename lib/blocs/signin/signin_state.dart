part of 'signin_bloc.dart';

sealed class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SigninState {}

final class SignInFailure extends SigninState {}

final class SignInProcess extends SigninState {}

final class SignInSuccess extends SigninState {}
