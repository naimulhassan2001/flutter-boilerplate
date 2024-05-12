



class RegExpHelper {
  static RegExp emailRegexp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');
}
