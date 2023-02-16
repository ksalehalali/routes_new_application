import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routesnewapplication/business_logic/cubit/register_cubit/register_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/web_services/registeration_web_service.dart';
import 'register_state.dart';

class RegistrationBloc extends Bloc<RegisterEvent,RegisterStates> {
  final   RegistrationWebService registrationWebService;

  RegistrationBloc(this. registrationWebService) :super(RegisterInitial()){
    on<LoadServiceEvent>((event ,emit)async{
      emit(TryingLogin());

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? prefToken = prefs.getString('lastToken');
        String? prefUsername = prefs.getString('userName');
        String? prefPassword = prefs.getString('password');

        print("last token ::: ${prefToken}");
        if(prefToken == null){
          print('null');
          final userInfo = await registrationWebService.tryToAutoLogin(prefUsername,prefPassword);

        } else {

        }
        emit(LoggedIn(userInfo));
      }catch (e){
       // emit(ServiceErrorState(msg: e.toString()));
      }
    });
  }


  static RegistrationBloc get (BuildContext context) {
    return BlocProvider.of(context);
  }

  var userInfo;

  void login(userName, password)async{
    userInfo = await registrationWebService.makeLoginRequest(userName, password);
    emit(LoggedIn(userInfo));
  }
}