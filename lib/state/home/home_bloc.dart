import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/models/home_images.dart';
import 'package:the_bhm_app_bloc/state/home/home_provider.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeProvider homeProvider;
  HomeBloc(this.homeProvider) : super(HomeStateInitial()) {
    on<HomeEventImagesFetch>(
      (event, emit) async {
        try {
          emit(HomeStateImagesLoading());
          final HomeImagesModel images = await homeProvider.getImages();
          emit(HomeStateImagesLoaded(images));
        } catch (e) {
          emit(HomeStateError(e.toString()));
        }
      },
    );
  }
}
