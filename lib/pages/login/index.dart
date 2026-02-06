import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/userController.dart';
import 'package:hm_shop/utils/toastUtils.dart';

// 可用账号：13200000001 -- 13200000010
// 可用密码：123456

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false;
  final Usercontroller _usercontroller = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _buildPhoneTextFiled() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "手机号不能为空";
        }
        // 校验手机号格式
        if (!RegExp(r"^1[3-9]\d{9}$").hasMatch(value)) {
          return "手机号格式不正确";
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          hintText: "请输入账号",
          fillColor: const Color.fromRGBO(243, 243, 243, 1),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25))),
    );
  }

  Widget _buildCodeTextFiled() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "密码不能为空";
        }
        // 密码的校验 6-16位的数字、字母或者下划线
        if (!RegExp(r"^[a-zA-Z0-9]{6,16}$").hasMatch(value)) {
          return "请输入6-16位的字母数字或者下划线";
        }
        return null;
      },
      obscureText: true,
      controller: _codeController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          hintText: "请输入密码",
          fillColor: const Color.fromRGBO(243, 243, 243, 1),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25))),
    );
  }

  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            _isChecked = value ?? false;
            setState(() {});
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(TextSpan(children: [
          TextSpan(text: "查看并同意"),
          TextSpan(text: "《隐私条款》", style: TextStyle(color: Colors.blue)),
          TextSpan(text: "和"),
          TextSpan(text: "《用户协议》", style: TextStyle(color: Colors.blue))
        ]))
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            if (_key.currentState!.validate()) {
              if (_isChecked) {
                _login();
              } else {
                ToastUtils.showToast(context, "请勾选用户协议");
              }
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          child: Text(
            "登录",
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
    );
  }

  void _login() async {
    try {
      final res = await loginAPI(
          {"account": _phoneController.text, "password": _codeController.text});
      // print(res);
      _usercontroller.updateUserInfo(res);
      // 写入持久化
      tokenManager.setToken(res.token);
      ToastUtils.showToast(context, "登录成功");
      Navigator.pop(context);
    } catch (e) {
      ToastUtils.showToast(context, (e as DioException).message);
    }
    // 此时一定登录成功
    // http状态码 2xx 业务状态码 业务执行成功 1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "惠多美登录",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
          key: _key,
          child: Container(
            padding: EdgeInsets.all(30),
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                _buildHeader(),
                SizedBox(
                  height: 30,
                ),
                _buildPhoneTextFiled(),
                SizedBox(
                  height: 20,
                ),
                _buildCodeTextFiled(),
                SizedBox(
                  height: 20,
                ),
                _buildCheckbox(),
                SizedBox(
                  height: 20,
                ),
                _buildLoginButton()
              ],
            ),
          )),
    );
  }
}
