import 'package:flutter/material.dart';
import 'package:SecondSpin/pages/login_page.dart';
import 'package:SecondSpin/pages/main_page.dart';
import 'package:SecondSpin/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.isRegistering}) : super(key: key);

  static Route<void> route({bool isRegistering = false}) {
    return MaterialPageRoute(
      builder: (context) => RegisterPage(isRegistering: isRegistering),
    );
  }

  final bool isRegistering;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  Future<void> _signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    final email = _emailController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;
    try {
      // 注册用户
      AuthResponse signUpResponse = await supabase.auth.signUp(
          email: email, password: password, data: {'username': username});

      // 获取注册用户的ID
      final userId = signUpResponse.user!.id;

      print('注册成功,欢迎$username用户ID:$userId');

      // 跳转到主页面
      Navigator.of(context)
          .pushAndRemoveUntil(MainScreen.route(), (route) => true);
    } on AuthException catch (error) {
      // context.showErrorSnackBar(message: error.message);
      print('$error');
    } catch (error) {
      // context.showErrorSnackBar(message: unexpectedErrorMessage);
      print('$error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Register'),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: formPadding,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: Text('Email'),
                labelStyle: TextStyle(color: Colors.black), // 标签样式
                hintStyle: TextStyle(color: Colors.grey), // 提示文本样式
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.black, width: 1.0), // 边框颜色和宽度
                  borderRadius: BorderRadius.circular(10.0), // 边框圆角
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black, width: 2.0), // 聚焦时的边框颜色和宽度
                  borderRadius: BorderRadius.circular(10.0), // 边框圆角
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            formSpacer,
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Password'),
                labelStyle: TextStyle(color: Colors.black), // 标签样式
                hintStyle: TextStyle(color: Colors.grey), // 提示文本样式
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.black, width: 1.0), // 边框颜色和宽度
                  borderRadius: BorderRadius.circular(10.0), // 边框圆角
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black, width: 2.0), // 聚焦时的边框颜色和宽度
                  borderRadius: BorderRadius.circular(10.0), // 边框圆角
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Required';
                }
                if (val.length < 6) {
                  return '6 characters minimum';
                }
                return null;
              },
            ),
            formSpacer,
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                label: Text(
                  'Username',
                ),
                labelStyle: TextStyle(color: Colors.black), // 标签样式
                hintStyle: TextStyle(color: Colors.grey), // 提示文本样式
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.black, width: 1.0), // 边框颜色和宽度
                  borderRadius: BorderRadius.circular(10.0), // 边框圆角
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black, width: 2.0), // 聚焦时的边框颜色和宽度
                  borderRadius: BorderRadius.circular(10.0), // 边框圆角
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Required';
                }
                final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
                if (!isValid) {
                  return '3-24 long with alphanumeric or underscore';
                }
                return null;
              },
            ),
            formSpacer,
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: _isLoading ? null : _signUp,
              child: const Text(
                'Register and Login',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            formSpacer,
            TextButton(
              onPressed: () {
                Navigator.of(context).push(LoginPage.route());
              },
              child: const Text(
                'I already have an account',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
