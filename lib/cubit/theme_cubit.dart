import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tp3/model/theme_model.dart';
import 'package:tp3/repository/theme_repository.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late ThemeRepository themeRepository;
  
  ThemeCubit() : super(ThemeInitial()) {
    themeRepository = ThemeRepository();
  }

  void reset() {
    emit(ThemeInitial());
  }

  Future<void> getThemes() async {
    emit(ThemeLoading());
    try {
      List<ThemeModel> themes = await themeRepository.getThemes();
      emit(ThemeLoaded(themes));
    } on Exception {
      emit(ThemeError("Error getting themes"));
    }
  }
}
