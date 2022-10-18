import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// 本地资源
import 'en_US.dart';
import 'zh_Hans.dart';
import 'zh_HK.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('zh', '');
  @override
  Map<String, Map<String, String>> get keys => {
    'en': en_US,
    'zh': zh_Hans,
    'zh_HK': zh_HK,
    'zh_Hans_US': zh_HK,
    'zh_TW': zh_HK,
    'zh_MO': zh_HK,
  };
}
