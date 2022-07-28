import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:crypto_currency/home/repository/home_repository.dart';

import '../model/home_detail.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ///implement event handler
  final HomeRepository _homeRepository;
  HomeBloc(this._homeRepository) : super(HomeLoadingState()) {
    on<LoadEvent>((event, emit) async {
      final activity = await _homeRepository.fetchNews();
      emit(HomeLoadedState(
          activity.count, activity.next, activity.previous, activity.results));
    });
  }
}
