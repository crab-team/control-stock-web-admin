import 'package:logger/logger.dart';

var logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(
    methodCount: 2, // number of method calls to be displayed
    errorMethodCount: 8, // number of method calls if stacktrace is provided
    lineLength: 180,
    colors: true,
    printEmojis: true,
  ),
);
