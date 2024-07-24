import 'package:demo/Constant/color_const.dart';
import 'package:demo/Views/Helper/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sizer/sizer.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class MainAuth extends StatefulWidget {
  const MainAuth({super.key});

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isAuthenticate = false;
  bool isPatternSet = false; // Flag to check if pattern is already set
  List<Offset> drawnPattern = [];
  String enteredPin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "PHONE AUTH",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: white),
        ),
        backgroundColor: green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: buildUI(),
      //floatingActionButton: fingerButton(),
    );
  }

  Widget buildUI() {
    return SizedBox(
      width: SizerUtil.width,
      child: Stack(
        children: [
          Positioned(
            bottom: 1.h,
            left: 5.w,
            right: 5.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getButton("FACE", 0, () {
                  getPhoneFaceDetectData();
                }),
                SizedBox(width: 10.w),
                getButton("SCREEN lOCK", 1, () {
                  getPhonePinAuth();
                }),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 15.h,
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3)),
                ],
                border: isAuthenticate == true
                    ? Border.all(color: blue, width: 2)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Account Balance",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  if (isAuthenticate)
                    Text(
                      "20,000 Rs.",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  if (!isAuthenticate)
                    Text(
                      "******",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getButton(title, index, Function onClick) {
    return MaterialButton(
      onPressed: () {
        onClick();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: black.withOpacity(0.2)),
      ),
      color: index == 0 ? green : blue,
      textColor: white,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 10.sp, fontWeight: FontWeight.bold, color: white),
      ),
    );
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => isAuthenticate = false);
  }

  getPhoneFaceDetectData() async {
    try {
      if (!isAuthenticate) {
        final bool canAuthenticateWithBiometrics =
            await auth.canCheckBiometrics;
        logcat('STEP-1:', canAuthenticateWithBiometrics);
        final bool canAuthenticate =
            canAuthenticateWithBiometrics || await auth.isDeviceSupported();
        logcat('STEP-2:', canAuthenticate);

        try {
          if (canAuthenticate) {
            final List<BiometricType> availableBiometrics =
                await auth.getAvailableBiometrics();
            logcat('STEP-3:', availableBiometrics);

            // Check if face authentication is available
            if (availableBiometrics.contains(BiometricType.strong)) {
              logcat('STEP-4:', availableBiometrics);
              final bool didAuthenticate = await auth.authenticate(
                  localizedReason: "Please authenticate to show bank balance",
                  options: const AuthenticationOptions(
                      biometricOnly: true,
                      useErrorDialogs: false,
                      sensitiveTransaction: true));
              logcat('STEP-5:', didAuthenticate);
              setState(() {
                isAuthenticate = didAuthenticate;
              });
            } else {
              logcat('STEP-6:', 'NOT AUTHENTICATE');
              Get.snackbar(
                  'ERROR', 'Face authentication not available on this device.');
            }
          } else {
            logcat('STEP-7:',
                'Cannot authenticate with biometrics or device not supported.');
          }
        } on PlatformException catch (e) {
          if (e.code == auth_error.notEnrolled) {
            logcat("ERROR", e);
            // Add handling of no hardware here.
          } else if (e.code == auth_error.lockedOut ||
              e.code == auth_error.permanentlyLockedOut) {
            // ...
          }
          logcat("PLATFORM_ERROR", e.message);
        }
        if (!mounted) {
          return;
        }
      } else {
        setState(() => isAuthenticate = false);
      }
    } catch (e) {
      logcat('ERROR:', 'An error occurred: $e');
    }
  }

  // FOR FACE RECOGNISATION
  Widget faceButton() {
    return FloatingActionButton(
      onPressed: () async {
        if (!isAuthenticate) {
          final bool canAuthenticateWithBiometrics =
              await auth.canCheckBiometrics;
          logcat('STEP-1:', canAuthenticateWithBiometrics);
          final bool canAuthenticate =
              canAuthenticateWithBiometrics || await auth.isDeviceSupported();
          logcat('STEP-2:', canAuthenticate);

          if (canAuthenticate) {
            final List<BiometricType> availableBiometrics =
                await auth.getAvailableBiometrics();
            logcat('STEP-3:', availableBiometrics);

            // Check if face authentication is available
            if (availableBiometrics.contains(BiometricType.face)) {
              logcat('STEP-4:', availableBiometrics);
              final bool didAuthenticate = await auth.authenticate(
                  localizedReason: "Please authenticate to show bank balance",
                  options: const AuthenticationOptions(
                      biometricOnly: true, sensitiveTransaction: true));
              logcat('STEP-5:', didAuthenticate);
              setState(() {
                isAuthenticate = didAuthenticate;
              });
            } else {
              logcat('STEP-6:', 'NOT AUTHENTICATE');
              Get.snackbar(
                  'ERROR', 'Face authentication not available on this device.');
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content:
              //         Text("Face authentication not available on this device."),
              //   ),
              // );
            }
          } else {
            logcat('STEP-7:',
                'Cannot authenticate with biometrics or device not supported.');
          }
        } else {
          setState(() {
            isAuthenticate = false;
          });
        }
      },
      child:
          isAuthenticate ? const Icon(Icons.lock) : const Icon(Icons.lock_open),
    );
  }

  getPhonePinAuth() async {
    if (!isAuthenticate) {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      logcat("fingerButton", canAuthenticateWithBiometrics);
      if (canAuthenticateWithBiometrics) {
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: "Please Authenticate to Show bank balance",
            options: const AuthenticationOptions(
              biometricOnly: false,
            ));
        setState(() {
          isAuthenticate = didAuthenticate;
        });
      }
    } else {
      setState(() {
        isAuthenticate = false;
      });
    }
  }

  // FOR FINGER PRINT
  // Widget fingerButton() {
  //   return FloatingActionButton(
  //     onPressed: () async {
  //       if (!isAuthenticate) {
  //         final bool canAuthenticateWithBiometrics =
  //             await auth.canCheckBiometrics;
  //         logcat("fingerButton", canAuthenticateWithBiometrics);
  //         if (canAuthenticateWithBiometrics) {
  //           final bool didAuthenticate = await auth.authenticate(
  //               localizedReason: "Please Authenticate to Show bank balance",
  //               options: const AuthenticationOptions(
  //                 biometricOnly: false,
  //               ));
  //           setState(() {
  //             isAuthenticate = didAuthenticate;
  //           });
  //         }
  //       } else {
  //         setState(() {
  //           isAuthenticate = false;
  //         });
  //       }
  //     },
  //     child:
  //         isAuthenticate ? const Icon(Icons.lock) : const Icon(Icons.lock_open),
  //   );
  // }
}
