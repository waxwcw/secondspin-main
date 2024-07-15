import 'package:flutter/material.dart';
import 'package:SecondSpin/pages/main_page.dart';
import 'package:SecondSpin/pages/welcome_page.dart';
import 'package:SecondSpin/utils/constants.dart';

// 根据初始身份验证状态将用户重定向到相应的页面
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);

    final session = supabase.auth.currentSession;
    if (session == null) {
      Navigator.of(context)
          .pushAndRemoveUntil(WelcomeView.route(), (route) => false);
    } else {
      Navigator.of(context)
          .pushAndRemoveUntil(MainScreen.route(), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: preloader);
  }
}
