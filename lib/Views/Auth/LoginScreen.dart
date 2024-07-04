import 'package:demo/Constant/color_const.dart';
import 'package:demo/Constant/string_const.dart';
import 'package:demo/Views/Auth/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passCtr = TextEditingController();

  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      Strings.login,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: blue,
                          fontWeight: FontWeight.w800),
                    ),
                    const Text(Strings.logindetails),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.h),
            getCustomField(emailCtr, Strings.enterEmail, 1),
            SizedBox(
              height: 2.h,
            ),
            getCustomField(passCtr, Strings.enterPass, 2),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Forgot Password ?"),
              ],
            ),
            SizedBox(height: 5.h),
            GestureDetector(
              onTap: () {
                //   Get.to(FaceRecognitionPage());
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
                const Text("Dont Have Account ?"),
                SizedBox(
                  width: 3.w,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const SignUpScreen());
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getCustomField(
      TextEditingController controller, String hint, int index) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {},
      keyboardType:
          index == 1 ? TextInputType.emailAddress : TextInputType.name,
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
