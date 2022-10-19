import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:r_logger/r_logger.dart';

class Runtime {
  static dynamic _consolePrinter;

  static bool _isSaveLogToFile = true;

  static Future<void> prepareRuntime() async {
    _consolePrinter = print;
    Directory dic = await getApplicationSupportDirectory();
    RLogger.initLogger(filePath: "${dic.path}/log/", isWriteFile: _isSaveLogToFile, fileName: "member_management.log");
  }

  static void runZoned(void Function() f) {
    FlutterError.onError = (FlutterErrorDetails details) async {
      _consolePrint('zone:FlutterError.onError: $details');
      if (details.stack != null) {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      }
    };

    runZonedGuarded(f, (Object obj, StackTrace stack) {
      _consolePrint('zone:onError: $obj, $stack');

      var details = _makeDetails(obj, stack);
      _reportError(details);
    }, zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          if(_isSaveLogToFile){
            RLogger.instance?.d(line);
          } else {
            parent.print(zone, line);
          }
        }));
  }

  static FlutterErrorDetails _makeDetails(Object obj, StackTrace stack) {
    return FlutterErrorDetails(exception: obj, stack: stack);
  }

  static void _reportError(FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  }

  static void _consolePrint(Object obj) {
    if (_consolePrinter != null) {
      _consolePrinter(obj);
    }
  }
}
