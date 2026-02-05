import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/dioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

Future<UserInfo> login(Map<String, dynamic> data) async {
  return UserInfo.fromJson(
      await dioRequest.post(HttpConstants.LOGIN, data: data));
}
