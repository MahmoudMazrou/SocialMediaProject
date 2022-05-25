import 'package:asochialmedia/models/message_model.dart';
import 'package:asochialmedia/models/social_user_model.dart';
import 'package:asochialmedia/shared/cubit/cubit.dart';
import 'package:asochialmedia/shared/cubit/states.dart';
import 'package:asochialmedia/shared/styles/colors.dart';
import 'package:asochialmedia/shared/styles/icon_broken.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;//

  ChatDetailsScreen({
    this.userModel,
  });

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(//هاد بعملو Builder عشان بدي استدعي حاجة قبل متبدا عرض فانا استدعيب المسجات هين
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(
          receiverId: userModel.uId,
        );

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel.image,//باعتو بكونستركتور عشان اصلوuserModel
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel.name,
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(//ConditionalBuilder عشان بدي احط شرط
                condition:0==0,//اذا في مسجا
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index)
                          {
                            var message = SocialCubit.get(context).messages[index];//جيب المسجات

                            if(SocialCubit.get(context).userModel.uId == message.senderId)//اذ المسج الي جاي السندر تبعها انا
                              return buildMyMessage(message,context,index);//تعت السندر الي عليمين

                            return buildMessage(message);//الثانية
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,//ارتفاع الفاصل 15!!
                          ),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,//هاي معنها انو قص الايقونة او قص لحدودالي خارج البوردير يعني
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ...',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                  messageController.text="";//بفرغ حقل النص
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            model.text,
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model,context, index) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(
              .2,
            ),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min, //هاي بتجعل الرو يوخد اقل مساحة ممكنة يعني مساحة العناصر الي بداخله
            children: [
              Text(
                model.text,
              ),
              SizedBox(
                width: 5.0,
              ),
              InkWell(
                onTap: () {
                  SocialCubit.get(context).deleteMessages(SocialCubit.get(context).messagesId[index],userModel.uId);

                },
                child: Icon(
                  IconBroken.Delete,
                  size: 16.0,
                  color: Colors.red,
                ),
              ),

            ],
          ),

        ),
      );
}
