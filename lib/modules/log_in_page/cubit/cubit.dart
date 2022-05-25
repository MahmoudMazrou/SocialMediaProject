import 'package:asochialmedia/modules/log_in_page/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  void _showErrorDialog(String message,BuildContext context){
    showDialog(
      context: context,
      builder: (ctx)=>AlertDialog(
        title: Text("an Error Occurred!"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text("OKay"),
            onPressed: (){
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),

    );
  }

  void userLogin({
    @required String email,
    @required String password,
    @required BuildContext context,

  }) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(// واضحة وصريحة
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      emit(SocialLoginSuccessState(value.user.uid));//ببعت  معها اليوزر اي دي المسجل عشان استقبلو
    }).catchError((error)
    {
      _showErrorDialog("${error.message}",context);


      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialChangePasswordVisibilityState());
  }
}
