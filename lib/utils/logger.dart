// ignore_for_file: avoid_print
// ignore_for_file: constant_identifier_names

class Logger {
  static const String _TAG = 'Bingnuos';
  static const String _TAG_ERROR = 'BingnuosError';

  static void i(String message) {
    print('[i] $_TAG: $message');
  }

  static void d(String message) {
    print('[d] $_TAG: $message');
  }

  static void e(String message, [Object? error]) {
    print('[e] $_TAG_ERROR: $message');
    if (error != null) {
      print(error);
    }
  }
}
