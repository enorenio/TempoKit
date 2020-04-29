import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tempokit/util/bloc/account/account_bloc.dart';
import 'package:tempokit/util/bloc/auth/auth_bloc.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/view/account/companies_section.dart';
import 'package:tempokit/view/account/contacts_section.dart';
import 'package:tempokit/view/account/logout_button.dart';
import 'package:tempokit/view/account/more_section.dart';
import 'package:tempokit/view/account/notifications_section.dart';
import 'package:tempokit/view/account/user_info_section.dart';
import 'package:tempokit/view/widgets/gray_card.dart';
import 'package:tempokit/view/widgets/loading_widget.dart';
import 'package:tempokit/view/widgets/temp_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<AccountBloc>(context).add(GetCompanies());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, userState) {
      if (userState is Loading) {
        print('$this loading');
        return loadingWidget;
      } else if (userState is AuthError) {
        showError(context, userState);
      }
      if (userState is Authenticated) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    UserInfoSection(userState: userState),
                    GrayCard(
                      child: CompaniesSection(),
                    ),
                    GrayCard(
                      child: NotificationSection(),
                    ),
                    GrayCard(
                      child: ContactSection(),
                    ),
                    GrayCard(
                      child: MoreSection(),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width * .9,
                      height: 50,
                      child: LogoutButton(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      return tempWidget;
    });
  }
}
