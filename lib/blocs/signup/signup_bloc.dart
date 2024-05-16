import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository _userRepository;

  SignUpBloc(this._userRepository) : super(SignupInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        MyUser myUser =
            await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(myUser);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
