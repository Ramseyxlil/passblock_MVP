part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class NavigationAction extends NavigationEvent {
  const NavigationAction(this.index);
  final int index;

  @override
  List<Object> get props => [index];
}
