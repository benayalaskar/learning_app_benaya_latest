import 'package:bloc/bloc.dart';
import 'package:learning_app_benaya_latest/data/repository/api_repository.dart';
import 'package:learning_app_benaya_latest/data/response/login_response/login_response.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepository apiRepository;
  LoginBloc(this.apiRepository) : super(LoginInitial()) {
    on<LoginEvent>(
      (event, emit) async {
        //penambahan event handler untuk loginbuttonpressed
        if (event is LoginButtonPressed) {
          emit(LoginInProgress());

          try {
            final response = await apiRepository.authenticate(
                event.identifier, event.identifier);
            emit(LoginSuccess(response));
          } catch (e) {
            emit(LoginFailed(e.toString()));
          }
        }
      },
    );
  }
}
