import 'package:flutter/material.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/presentation/widgets/logo_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
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
          ListTile(
            leading: const Icon(Icons.lightbulb_outline),
            title: Text(TranslationConstants.notes.translate(context)),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.archive_outlined),
            title: Text(TranslationConstants.archive.translate(context)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: Text(TranslationConstants.trash.translate(context)),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text(TranslationConstants.settings.translate(context)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
