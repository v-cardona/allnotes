import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  final Function onChanged;
  final String errorText;

  const EmailInput({Key key, @required this.onChanged, @required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
          child: TextField(
            onChanged: onChanged,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo Electrónico',
                errorText: errorText),
          ),
        );
  }
}