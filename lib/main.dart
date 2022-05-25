
import 'package:asochialmedia/modules/log_in_page/log_in_page.dart';
import 'package:asochialmedia/modules/spllash_screen_page/spllash_screen_page.dart';
import 'package:asochialmedia/shared/bloc_observer.dart';
import 'package:asochialmedia/shared/cubit/cubit.dart';
import 'package:asochialmedia/shared/cubit/states.dart';
import 'package:asochialmedia/shared/network/local/cache_helper.dart';
import 'package:asochialmedia/shared/styles/themes.dart';
import 'package:asochialmedia/social_layout.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp();
  await Firebase.initializeApp();

  bool isDark = CacheHelper.getData(key: 'isDark');
 var uId = CacheHelper.getData(key: 'uId');
  Widget widget;
  if(uId != null)
  {
    widget = SocialLayout();
  } else
  {
  widget = LogInPage();
  }


  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,

  ));}

class MyApp extends StatelessWidget {

  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
   this.startWidget,
  });


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: ( context, state) {} ,
        builder: ( context, state) {

          return  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,

          home: startWidget,
        );
        }

      ),
    );
  }
}
