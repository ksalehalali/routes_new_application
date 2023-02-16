import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routesnewapplication/presentation/Auth/login.dart';
import 'business_logic/cubit/internet_bloc/internet_bloc.dart';
import 'business_logic/cubit/register_cubit/register_cubit.dart';
import 'business_logic/cubit/register_cubit/register_event.dart';
import 'data/web_services/registeration_web_service.dart';
import 'presentation/app_router.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( ServiceApp());
}

class ServiceApp extends StatelessWidget {
   ServiceApp({Key? key}) : super(key: key);
  RegistrationWebService registrationWebService = RegistrationWebService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ScreenUtilInit(
            designSize: const Size(390, 815),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return RepositoryProvider<RegistrationRepo>(
                  create: (context) => RegistrationRepo(),
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider<RegistrationBloc>(
                        create: (context) => RegistrationBloc(registrationWebService),),
                      BlocProvider<InternetBloc>(
                        create: (context) => InternetBloc(),
                      ),
                    ],
                    child: Login(),
                  ));
            }));
  }
}

class RegistrationRepo {}
