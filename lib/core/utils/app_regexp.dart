abstract class AppRegExp {
  //------------- Regex -------------
  static const String emailValidationPattern =
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String passwordValidationPattern =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
}
