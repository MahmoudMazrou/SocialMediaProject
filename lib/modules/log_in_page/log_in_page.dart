import 'package:asochialmedia/modules/log_in_page/cubit/cubit.dart';
import 'package:asochialmedia/modules/log_in_page/cubit/states.dart';
import 'package:asochialmedia/modules/register_screen/register_screen.dart';
import 'package:asochialmedia/shared/components/components.dart';
import 'package:asochialmedia/shared/network/local/cache_helper.dart';
import 'package:asochialmedia/social_layout.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogInPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context, state){

          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(//تاع الشيرد ريفيرنسس هاد لكلاس عشان احفظ اليوزر الي دخل
              key: 'uId',
              value: state.uId,//استقبلنا اليوزر اي دي الي بعتناه
            ).then((value)
            {
              navigateAndFinish(
                context,
                SocialLayout(),
              );
            });
          }
        },
          builder: (context, state) {
            var cubit = SocialLoginCubit.get(context);



          return  Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: SvgPicture.asset(
                        'assets/images/waves.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      height: 100,
                      child: CircleAvatar(
                        radius:33 ,
                        backgroundColor:  const Color.fromARGB(255, 231, 0, 138),
                        child:   Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            radius:33 ,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: const Color.fromARGB(255, 231, 0, 138),
                              size: 60,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 330,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              child: Container(
                                height: 300,
                                width: 300,
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(width: 280,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,top: 20),
                                    child: defaultFormField(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'please enter your email address';
                                        }
                                      },
                                      label: 'Email Address',
                                      prefix: Icons.email_outlined,
                                    ),
                                  ),

                                ),
                                Container( width: 300,
                                  child: SizedBox(
                                    height: 15.0,

                                  ),

                                ),
                                Container( width: 280,
                                  child:
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,),
                                    child: defaultFormField(
                                      controller: passwordController,
                                      type: TextInputType.visiblePassword,
                                      suffix:cubit.suffix,
                                      onSubmit: (value) {},
                                      isPassword:
                                      cubit.isPassword,
                                      suffixPressed: () {
                                        cubit.changePasswordVisibility();
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'password is too short';
                                        }
                                      },
                                      label: 'Password',
                                      prefix: Icons.lock_outline,
                                    ),
                                  ),
                                ),

                                Container( width: 300,
                                  child: SizedBox(
                                    height: 30.0,

                                  ),
                                ),
                                Container(
                                  width: 120,
                                  child:  ConditionalBuilder(
                                    condition: state is! SocialLoginLoadingState,
                                    builder: (context) => defaultButton(
                                      function: () {
                                        if (formKey.currentState.validate()) {
                                          SocialLoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context,
                                          );
                                        }
                                      },
                                      text: 'login',
                                      isUpperCase: true,
                                    ),
                                    fallback: (context) =>
                                        Center(child: CircularProgressIndicator()),
                                  ),
                                  ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child:   Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: const Color.fromARGB(255, 231, 0, 138)),
                          ),
                          defaultTextButton(
                            function: () {
                              navigateTo(
                                context,
                                RegisterScreen(),
                              );
                            },
                            text: 'register',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
