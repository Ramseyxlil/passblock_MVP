import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, int> {
  NavigationBloc() : super(0) {
    on<NavigationAction>((event, emit) {
      emit(event.index);
    });
  }
}
