import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lion12/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:lion12/component/text_field.dart';
import 'package:lion12/user/view/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    

    final response = await http.post(
      Uri.parse('http://43.201.112.183/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String, String>{
        'memberId': email,
        'password': password,
      })
    );

    if (response.statusCode == 200) {
      print('Login successful');
      print('Response body: ${response.body}');

      // TODO: 로그인 성공 후 페이지 이동 또는 토큰 저장 등의 작업 수행
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      print('Login failed: ${response.statusCode}');
      // TODO: 사용자에게 오류 메시지 표시
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  hintText: 'Email',
                  controller: _emailController,
                  onChanged: (value) {

                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: _passwordController,
                  onChanged: (value) {

                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
