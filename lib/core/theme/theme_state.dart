sealed class ThemeState {}
class ThemeInitial extends ThemeState {}
class ThemeChanged extends ThemeState {
  final String theme;

  ThemeChanged(this.theme);
}
class ThemeError extends ThemeState {
  final String message;

  ThemeError(this.message);
}