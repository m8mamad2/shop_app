import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project3/src/view/main_screens/domain/entities/favorite_db_entity.dart';
import 'package:project3/src/view/main_screens/domain/usecse/favorite_db_usecaes.dart';

part 'favorite_db_event.dart';
part 'favorite_db_state.dart';

class FavoriteDbBloc extends Bloc<FavoriteDbEvent, FavoriteDbState> {
  FavoriteDBUseCase useCase;
  FavoriteDbBloc(this.useCase) : super(InitialFavoriteDBState()) {
    on<InitialFavoriteDBEvent>((event, emit) async {
      emit(LoadingFavoriteDBState());

      List<FavoriteDBEntity> data = await useCase.getFromBox();

      try {
        if (event is AddToFavoriteDBEvent)await useCase.addToBox(event.favoriteDBEntity);
        if (event is DeleteFromFavoriteDBEvent)await useCase.deleteFromBox(event.index);
        if (event is ClearFavoriteDBEvent)await useCase.clearBox();

        emit(SuccessFavoriteDBState(data: data));
      } catch (e) {
        emit(FailFavoriteDBState());
      }
    });
  }
}
