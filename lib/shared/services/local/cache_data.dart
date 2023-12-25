import 'package:pre/models/user_model.dart';
import 'package:pre/shared/services/local/cahce_helper.dart';

class CacheData {
  static String uId = (CacheHelper.getCacheData(key: 'uId') == null)
      ? ''
      : CacheHelper.getCacheData(key: 'uId');
}

String? token;
bool onBoarding = (CacheHelper.getCacheData(key: 'onBoarding') == null)
    ? false
    : CacheHelper.getCacheData(key: 'onBoarding');
bool ISLOGIN = (CacheHelper.getCacheData(key: 'login') == null)
    ? false
    : CacheHelper.getCacheData(key: 'login');

UserModel? CURRENTUSER;
