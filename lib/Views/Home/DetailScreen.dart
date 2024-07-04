import 'package:demo/Models/HomeModel.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  DetailScreen(this.data, {super.key});

  HomeModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("DetailScreen"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(right: 7.w, left: 7.w),
                  child: Text(data.id.toString())),
              const Divider(),
              Container(
                  margin: EdgeInsets.only(right: 7.w, left: 7.w),
                  child: Text(data.title)),
              const Divider(),
              Container(
                  margin: EdgeInsets.only(right: 7.w, left: 7.w),
                  child: Text(data.body)),
              const Divider(),
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: () async {
                  final call = Uri.parse('tel:+91 9876543210');
                  if (await canLaunchUrl(call)) {
                    launchUrl(call);
                  } else {
                    throw 'Could not launch $call';
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(right: 7.w, left: 7.w),
                    child: const Text(
                      "Make a Call",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    )),
              ),
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: () {
                  launchEmailSubmission();
                },
                child: Container(
                    margin: EdgeInsets.only(right: 7.w, left: 7.w),
                    child: const Text(
                      "Send Email",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    )),
              ),
            ]));
  }

  void launchEmailSubmission() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'myOwnEmailAddress@gmail.com',
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
