import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/user.dart';

/**
 * GetX用法
 * 1、安装GetX插件
 * 2、定义一个继承GetxController的对象
 * 3、对象中定义需要共享的属性
 * 4、数据需要响应式更新-需要给初始值以.obs结尾
 * 5、UI显示Getx数据需使用Obx包裹函数中使用
 * 6、UI中使用Getx需要一个put和find动作
 * 7、必须先put一次，才可以find
 * 8、put仅一次，find可多次
*/

// 需要共享的对象，要有一些共享的属性，属性需要响应式更新
class Usercontroller extends GetxController {
  // user对象被监听了，想要取值的话，需要 user.value
  // .obs表示该数据为响应式数据
  // 被.obs修饰的数据包了一层，赋值直接赋值value
  var user = UserInfo.fromJson({}).obs;
  updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
