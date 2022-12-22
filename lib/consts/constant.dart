

class Constant {
  static const String api = 'http://192.168.191.22:8080';
  static const String localStorageKey = 'stojanche-krstevski';

  static Uri getFullUri(String path) {
    return Uri.parse('$api$path');
  }
}
