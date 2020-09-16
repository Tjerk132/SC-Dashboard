import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:flutter_test_project/data/image_dao.dart';

class Logger {

  Logger({@required this.name, this.timedPrinting = false});

  bool timedPrinting;

  Type name;

  bool supportsAnsiEscapes = io.stdout.supportsAnsiEscapes;

  log({Level level = Level.info, String message, Type exception = Exception}) {
    LogRecord lr = new LogRecord(level, message);
    lr.exception = exception.toString();
    doLog(lr);
  }

  doLog(LogRecord lr) {
    lr.loggerName = name.toString();
    String message = createLogMessage(lr).toString();
    printLogRecord(message, lr.level);
  }

  printLogRecord(String message, Level level) {
    if(supportsAnsiEscapes) {
      print(level.inColor(message));
    }
    else print(message);
  }

  StringBuffer createLogMessage(LogRecord lr) {
    StringBuffer buffer = new StringBuffer();
    if(timedPrinting) {
      buffer.write(getTimePrint());
    }
    buffer.writeAll(List<String>.from([
      '(${this.name}) ',
      '${lr.level.print}: ',
      '[${lr.message}]'
    ]));
    return buffer;
  }

  getTimePrint() => '[${DateTime.now()}] ';
}

class LogRecord {
  LogRecord(this.level, this.message);

  Level level;

  String message;

  String loggerName;

  String exception;
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

