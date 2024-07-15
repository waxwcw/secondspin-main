import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SecondSpin/pages/login_page.dart';
import 'package:SecondSpin/pages/register_page.dart';
import 'package:SecondSpin/widgets/round_button.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => const WelcomeView(),
    );
  }

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            "assets/welcom_bg.jpg",
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome\nto SecondSpin",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Buy and sell secondhand products quickly",
                      style: TextStyle(
                          color: const Color(0xffFCFCFC).withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RoundButton(
                    title: "Sign In With Email",
                    bgColor: const Color(0xff5383EC),
                    onPressed: () {
                      Navigator.of(context).push(LoginPage.route());
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RoundButton(
                    title: "Sign Up With Email",
                    onPressed: () {
                      Navigator.of(context).push(RegisterPage.route());
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
