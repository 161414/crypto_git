part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  HomeLoadedState(this.count, this.next, this.previous, this.results);

  @override

  /// implement props
  List<Object?> get props => [
        count,
        next,
        previous,
        results,
      ];
}
