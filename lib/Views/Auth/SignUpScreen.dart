import 'package:demo/Constant/color_const.dart';
import 'package:demo/Constant/string_const.dart';
import 'package:demo/Views/Auth/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController nameCtr = TextEditingController();

  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 7.w, right: 7.w, top: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.signup,
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: blue,
                            fontWeight: FontWeight.w800),
                      ),
                      const Text(Strings.filldetails),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              getCustomField(passCtr, Strings.name, 3),
              SizedBox(
                height: 2.h,
              ),
              getCustomField(passCtr, Strings.contact, 4),
              SizedBox(
                height: 2.h,
              ),
              getCustomField(emailCtr, Strings.enterEmail, 1),
              SizedBox(
                height: 2.h,
              ),
              getCustomField(passCtr, Strings.enterPass, 2),
              SizedBox(
                height: 2.h,
              ),

              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text("Forgot Password ?"),
              //   ],
              // ),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  Get.to(const LoginScreen());
                },
                child: Container(
                  height: 5.5.h,
                  width: SizerUtil.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blue,
                  ),
                  child: Center(
                      child: Text(
                    Strings.login,
                    style: TextStyle(fontSize: 10.sp, color: white),
                  )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Already Have Account?"),
                  SizedBox(
                    width: 3.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.to(const Signupscreen());
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: blue,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCustomField(
      TextEditingController controller, String hint, int index) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {},
      keyboardType: index == 1
          ? TextInputType.emailAddress
          : index == 4
              ? TextInputType.number
              : TextInputType.name,
      obscureText: index == 2 ? obsecureText : false,
      validator: (value) {
        if (value!.isEmpty) {
          index == 1 ? "Enter Email" : "Enter Password";
        }
        return '';
      },
      decoration: InputDecoration(
          hintText: hint,
          // errorText: index == 1 ? "Enter Email Id" : "Enter Password",
          suffixIcon: index == 2
              ? GestureDetector(
                  onTap: () {
                    obsecureText = !obsecureText;
                    setState(() {});
                  },
                  child: Icon(obsecureText == true
                      ? Icons.visibility_off
                      : Icons.visibility))
              : null),
    );
  }
}
