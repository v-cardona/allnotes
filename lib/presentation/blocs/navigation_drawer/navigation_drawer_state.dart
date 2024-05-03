part of 'navigation_drawer_cubit.dart';

// fab, it not used, is only for made the necesary space
enum NavbarItem { notes, archive, deleted }

class NavigationDrawerState extends Equatable {
  final NavbarItem navbarItem;

  const NavigationDrawerState(this.navbarItem);

  @override
  List<Object> get props => [navbarItem];
}
