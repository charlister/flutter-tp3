part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {
  ThemeInitial();
}

class ThemeLoading extends ThemeState {
  ThemeLoading();
}

class ThemeLoaded extends ThemeState {
  final List<ThemeModel> themes;

  ThemeLoaded(this.themes);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemeLoaded && other.themes == themes;
  }

  @override
  int get hashCode => themes.hashCode;
}

class ThemeError extends ThemeState {
  final String message;

  ThemeError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemeError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}