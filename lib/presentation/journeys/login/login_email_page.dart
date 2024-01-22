import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/presentation/journeys/login/text_privacy_terms.dart';
import 'package:allnotes/presentation/widgets/text_input_widget.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key});

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(TranslationConstants.login.translate(context)),
          backgroundColor: AppColor.iron,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_50.w,
            vertical: Sizes.dimen_30.h,
          ),
          child: Column(
            children: [
              TextInputWidget(
                label: TranslationConstants.email,
                controller: _emailController,
                suffixIcon: Icons.email_rounded,
                textInputType: TextInputType.emailAddress,
              ),
              const Expanded(child: SizedBox.shrink()),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(TranslationConstants.continueEmail.translate(context)),
                  ],
                ),
              ),
              SizedBox(
                height: Sizes.dimen_50.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_80.w,
                ),
                child: const TextPrivacyTerms(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
