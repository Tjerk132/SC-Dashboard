import 'package:flutter/material.dart';
import 'dart:io' as io;

class Logger {

  Logger({@required this.name, this.timedPrinting = false});

  bool timedPrinting;

  Type name;

  bool supportsAnsiEscapes = io.stdout.supportsAnsiEscapes;

  void log(String message, {Type error}) {
    LogRecord lr = new LogRecord(Level.info, message);
    doLog(lr, error);
  }

  void warn(String message, {Type error}) {
    LogRecord lr = new LogRecord(Level.warning, message);
    doLog(lr, error);
  }

  void doLog(LogRecord lr, Type error) {
    addError(lr, error);
    lr.loggerName = name.toString();
    String message = createLogMessage(lr).toString();
    printLogRecord(message, lr);
  }

  void addError(LogRecord lr, Type error) {
    if(error != null) {
      lr.error = error;
      lr.throwError = true;
    }
  }

  StringBuffer createLogMessage(LogRecord lr) {
    StringBuffer buffer = new StringBuffer();
    if(timedPrinting) {
      buffer.write(timePrint);
    }
    buffer.writeAll(List<String>.from([
      '(${this.name}) ',
      '${lr.level.print}: ',
      '[${lr.message}]'
    ]));
    return buffer;
  }

  void printLogRecord(String message, LogRecord lr) {
    if(supportsAnsiEscapes) {
      print(lr.level.inColor(message));
    }
    print(message);
    if(lr.throwError) {
      throw '${lr.error}: [${lr.message}]';
    }
  }

  String get timePrint => '[${DateTime.now()}] ';
}

class LogRecord {
  LogRecord(this.level, this.message);

  final Level level;
  final String message;

  String loggerName;
  bool throwError = false;
  Type error;
}

enum Level {
  warning,
  info
}

extension LevelExtension on Level {
  String get print => this.toShortString().toUpperCase();

  String inColor(String text) {
    switch(this) {
      case Level.warning:
        return '\x1B[31m' + text + '\x1B[37m';
      case Level.info:
      default:
        return '\x1B[94m' + text + '\x1B[37m';
    }
  }

  // get the value of the enum
  String toShortString() => this.toString().split('.').last;
}

