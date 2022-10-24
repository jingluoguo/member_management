import 'dart:async';

import 'dart:io';

import 'package:intl/intl.dart';

// import 'package:r_logger/r_logger.dart';

class LoggerUtil{

  String  _tag = 'LoggerUtil';

  bool _writeFile = false;

  late _RFileWriter _writer;

  final StreamController<RLoggerData> _dataController =
  StreamController.broadcast();

  static final LoggerUtil _instance = LoggerUtil._internal();

  factory LoggerUtil() => _instance;

  /// 默认3天
  late int _day;

  late String _filePath;

  late Timer _timer;

  LoggerUtil._internal(){
    _day = 3;
    _dataController.stream.listen(_handleWriteFile);
    _timer = Timer.periodic(const Duration(days: 1), (timer) {
      deleteExpiredFiles();
    });
  }

  void changeIsWriteFile(bool isWriteFile){
    _writeFile = isWriteFile;
  }

  /// 处理过期日志文件
  Future<void> deleteExpiredFiles() async {
    if((_filePath.isEmpty || !Directory(_filePath).existsSync())) return;
    Stream<FileSystemEntity> fileList = Directory(_filePath).list();
    await for(FileSystemEntity file in fileList){
      File f = File(file.path);
    }
  }

  void changeExpiredDay(int day){
    _day =  day;
  }

  void initLogger({required String filePath, bool isWriteFile = false, String? fileName, String tag = 'LoggerUtil'}){
    _tag = tag;
  }

  void _handleWriteFile(RLoggerData event) {
    if (event.isWriteFile != true) return;
    switch (event.level) {
      case RLoggerLevel.debug:
        _writer.writeLog(
            '\n (${event.tag})${DateFormat('yyyy-MM-dd HH:mm:ss').format(event.dateTime!)}:${event.message}\n');
        break;
      case RLoggerLevel.info:
        _writer.writeLog(
            '\n(${event.tag})${DateFormat('yyyy-MM-dd HH:mm:ss').format(event.dateTime!)}:${event.message}\n');
        break;
      case RLoggerLevel.error:
        _writer.writeLog(
            '\n(${event.tag})${DateFormat('yyyy-MM-dd HH:mm:ss').format(event.dateTime!)}:${event.message}\n--->Error:${event.error}\n--->StackTrace:${event.stackTrace.toString()}\n');
        break;
    }
  }
}

class _RFileWriter {
  /// write file
  late File file;

  _RFileWriter(String filePath, String? fileName) {
    Directory rootPath = Directory(filePath);
    file = File(
        '${rootPath.path}${fileName ?? '${DateFormat('yyyy_MM_dd').format(DateTime.now())}.log'}');
  }

  /// file log write.
  ///
  /// android platform: your need to require write storage permission.
  ///
  /// [path] is the file path to write log message.
  /// [message] is the log message.
  Future<void> writeLog(String message) async {
    if (!file.existsSync()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(message, mode: FileMode.append);
    return null;
  }
}

enum RLoggerLevel {
  debug,
  info,
  error,
}

class RLoggerData {
  final String tag;
  final RLoggerLevel level;
  final String message;
  final Object? error;
  final StackTrace? stackTrace;
  final DateTime? dateTime;
  final bool? isWriteFile;

  RLoggerData(this.tag, this.level, this.message,
      {this.error, this.stackTrace, this.dateTime, this.isWriteFile});
}
