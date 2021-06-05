import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:flutter/material.dart';

import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_16.w,
        ),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.dimen_20.w,
              vertical: Sizes.dimen_5.h,
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                SizedBox(
                  width: Sizes.dimen_20.w,
                ),
                Expanded(
                  child: Text(
                    TranslationConstants.searchYourNotes.translate(context),
                    softWrap: false,
                  ),
                ),
                CircleAvatar(
                  child: Icon(Icons.face),
                  radius: Sizes.dimen_17,
                ),
              ],
            ),
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
