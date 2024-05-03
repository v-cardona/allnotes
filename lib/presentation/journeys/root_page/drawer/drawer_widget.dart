import 'package:allnotes/presentation/blocs/navigation_drawer/navigation_drawer_cubit.dart';
import 'package:flutter/material.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/presentation/widgets/logo_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex:
          context.read<NavigationDrawerCubit>().state.navbarItem.index,
      onDestinationSelected: (index) {
        if (index != 3) {
          context
              .read<NavigationDrawerCubit>()
              .getNavBarItem(NavbarItem.values[index]);
        } else {
          // open settings
        }
        Scaffold.of(context).closeDrawer();
      },
      children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const LogoWidget(
                height: Sizes.dimen_200,
              ),
              Text(
                TranslationConstants.appTitle.translate(context),
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.lightbulb_outline),
          label: Text(
            TranslationConstants.notes.translate(context),
          ),
        ),
        const Divider(),
        NavigationDrawerDestination(
          icon: const Icon(Icons.archive_outlined),
          label: Text(
            TranslationConstants.archive.translate(context),
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.delete_outline),
          label: Text(
            TranslationConstants.delete.translate(context),
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.settings_outlined),
          label: Text(
            TranslationConstants.settings.translate(context),
          ),
        ),
      ],
    );
  }
}
