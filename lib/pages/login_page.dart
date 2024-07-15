import 'package:SecondSpin/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:SecondSpin/pages/main_page.dart';
import 'package:SecondSpin/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const LoginPage());
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context)
          .pushAndRemoveUntil(MainScreen.route(), (route) => false);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (_) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kscaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Sign In'),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: ListView(
        padding: formPadding,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black), // 标签样式
              hintStyle: TextStyle(color: Colors.grey), // 提示文本样式
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.black, width: 1.0), // 边框颜色和宽度
                borderRadius: BorderRadius.circular(10.0), // 边框圆角
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.black, width: 2.0), // 聚焦时的边框颜色和宽度
                borderRadius: BorderRadius.circular(10.0), // 边框圆角
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          formSpacer,
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.black), // 标签样式
              hintStyle: TextStyle(color: Colors.grey), // 提示文本样式
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.black, width: 1.0), // 边框颜色和宽度
                borderRadius: BorderRadius.circular(10.0), // 边框圆角
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.black, width: 2.0), // 聚焦时的边框颜色和宽度
                borderRadius: BorderRadius.circular(10.0), // 边框圆角
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
            obscureText: true,
          ),
          formSpacer,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5383EC)),
            onPressed: _isLoading ? null : _signIn,
            child: const Text(
              'Login',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
