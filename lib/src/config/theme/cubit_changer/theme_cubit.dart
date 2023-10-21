import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_cubit_state.dart';

class ThemeCubit extends Cubit<ThemeCubitState> {
  ThemeCubit() : super(ThemeCubitInitial());

  bool _isDark = false;
  bool get isDark => _isDark;

  void changeTheme() {
    _isDark = !_isDark;

    emit(ThemeChangeCubit());
  }
}
