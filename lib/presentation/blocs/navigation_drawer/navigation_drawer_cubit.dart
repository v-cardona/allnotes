import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_drawer_state.dart';

class NavigationDrawerCubit extends Cubit<NavigationDrawerState> {
  NavigationDrawerCubit()
      : super(const NavigationDrawerState(NavbarItem.notes));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.notes:
        emit(const NavigationDrawerState(NavbarItem.notes));
        break;
      case NavbarItem.archive:
        emit(const NavigationDrawerState(NavbarItem.archive));
        break;
      case NavbarItem.deleted:
        emit(const NavigationDrawerState(NavbarItem.deleted));
        break;
    }
  }
}
