import 'package:asochialmedia/modules/new_post/new_post_screen.dart';
import 'package:asochialmedia/shared/components/components.dart';
import 'package:asochialmedia/shared/cubit/cubit.dart';
import 'package:asochialmedia/shared/cubit/states.dart';
import 'package:asochialmedia/shared/styles/icon_broken.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SocialLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {//اذ هاي لستيت اشتغلت اففتح ل النيو بوست فوق بصفحة جديدة مش زي الباقي بنفس الصفحة
          navigateTo(
            context,
            NewPostScreen(),
          );
        }
      },
      builder: (context, state)
      {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],//اعطيتو من لستة عشان يتغير كل منغير بلبوتم شيت
            ),
            actions: [
              IconButton(
                icon: Icon(
                  IconBroken.Notification,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  IconBroken.Search,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],//كل سكرن هتوخد من ليستا برضو
          bottomNavigationBar: BottomNavigationBar(// تنساش انو في ستايل احنا حطينو ب التيم
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);// بستدعيها عند الضغط من الكيوبت وطبعا ستيت منجمنت بلوك
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,//هاي الايقونات جاية من الملف الي حملناه
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}