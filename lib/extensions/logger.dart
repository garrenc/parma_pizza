import 'package:logger/logger.dart' as logger;

class Logger {
  static final logger.Logger logs = logger.Logger();

  static log(String message, {logger.Level level = logger.Level.error}) {
    logs.log(level, message);
  }
}
