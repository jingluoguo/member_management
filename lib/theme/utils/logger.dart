import 'package:r_logger/r_logger.dart';

class Logger {
  static void write(String text, {bool isError = false}) {
    Future.microtask(() => print('** $text. isError: [$isError]'));
    if(isError){
      RLogger.instance?.i(text, tag: 'GETX');
    } else {
      RLogger.instance?.d(text, tag: 'GETX');
    }
  }
}
