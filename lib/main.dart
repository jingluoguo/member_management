import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:member_management/theme/utils/get_extension.dart';
import 'package:member_management/routes/app_pages.dart';
import 'package:member_management/theme/utils/logger.dart';
import 'package:member_management/theme/utils/translation/translation_service.dart';
import 'package:member_management/theme/values/global_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => GlobalConfigService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      logWriterCallback: Logger.write,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.pages,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
    );
  }
}
