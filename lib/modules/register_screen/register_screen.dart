import 'package:asochialmedia/modules/register_screen/cubit/cubit.dart';
import 'package:asochialmedia/modules/register_screen/cubit/states.dart';
import 'package:asochialmedia/shared/components/components.dart';
import 'package:asochialmedia/shared/network/local/cache_helper.dart';
import 'package:asochialmedia/social_layout.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {//بقلك اذ تسجيل الخول تم وصحيح نفذ
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
          var cubit = SocialRegisterCubit.get(context);

          return Scaffold(
            body: SingleChildScrollView(
              child: Form(//عشان الفاليديت تنساش
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 35,
                          ),
                          child: Text(
                            "Register now to communicate\nwith friends",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 231, 0, 138),
                            ),
                          ),
                        )),
                    Container(
                      height: 400,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              child: Container(
                                height: 400,
                                width: 300,
                              ),
                            ),
                          ),
                          Container(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: 280,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10, top: 20),
                                      child: defaultFormField(
                                        controller: nameController,
                                        type: TextInputType.name,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'please enter your name';
                                          }
                                        },
                                        label: 'User Name',
                                        prefix: Icons.person,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 280,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10, top: 20),
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
                                  Container(
                                    width: 300,
                                    child: SizedBox(
                                      height: 15.0,
                                    ),
                                  ),
                                  Container(
                                    width: 280,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: defaultFormField(
                                        controller: passwordController,
                                        type: TextInputType.visiblePassword,
                                        suffix: cubit.suffix,
                                        onSubmit: (value) {},
                                        isPassword: SocialRegisterCubit.get(context)
                                            .isPassword,
                                        suffixPressed: () {
                                          SocialRegisterCubit.get(context)
                                              .changePasswordVisibility();
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
                                  Container(
                                    width: 280,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10, top: 20),
                                      child: defaultFormField(
                                        controller: phoneController,
                                        type: TextInputType.phone,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'please enter your phone number';
                                          }
                                        },
                                        label: 'Phone',
                                        prefix: Icons.phone,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 300,
                                    child: SizedBox(
                                      height: 25.0,
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    child: ConditionalBuilder(
                                      condition:
                                          state is! SocialRegisterLoadingState,
                                      builder: (context) => defaultButton(
                                        function: () {
                                          if (formKey.currentState.validate()) {
                                            SocialRegisterCubit.get(context)
                                                .userRegister(
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                    phone: phoneController.text,
                                                    context: context);
                                          }
                                        },
                                        text: 'register',
                                        isUpperCase: true,
                                      ),
                                      fallback: (context) => Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
