import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SigninEvent, SigninState> {
  final UserRepository _userRepository;

  SignInBloc(this._userRepository) : super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
      } catch (e) {
        emit(SignInFailure());
      }
    });

    on<SignOutRequired>((event, emit) async => await _userRepository.logOut());
  }
}
