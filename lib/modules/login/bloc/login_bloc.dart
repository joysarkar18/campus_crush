import 'package:bloc/bloc.dart';
import 'package:campus_crush/modules/login/bloc/login_event.dart';
import 'package:campus_crush/modules/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
  }
}
