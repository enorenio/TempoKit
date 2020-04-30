import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tempokit/model/company.dart';
import 'package:tempokit/util/bloc/account/account_bloc.dart';
import 'package:tempokit/util/errors.dart';
import 'package:tempokit/view/account/globals.dart';
import 'package:tempokit/view/account/new_company_view.dart';

class CompaniesSection extends StatefulWidget {
  CompaniesSection({Key key}) : super(key: key);

  @override
  _CompaniesSectionState createState() => _CompaniesSectionState();
}

class _CompaniesSectionState extends State<CompaniesSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is AccountError) {
          showError(context, state);
        }
        if (state is CompaniesState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myTitle('Organizations'),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 190.0,
                ),
                child: CompanyList(state: state),
              ),
              AddCompanyButton(),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class CompanyList extends StatelessWidget {
  final CompaniesState state;
  const CompanyList({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: state.companies.length,
        itemBuilder: (context, index) {
          Company current = state.companies[index];
          return CompanyListTile(state: state, current: current);
        });
  }
}

class CompanyListTile extends StatelessWidget {
  final CompaniesState state;
  final Company current;
  const CompanyListTile({Key key, this.state, this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: myText(current.name),
      trailing: current == state.current
          ? Icon(
              Icons.radio_button_checked,
              color: Theme.of(context).accentColor,
            )
          : Icon(
              Icons.radio_button_unchecked,
            ),
      onTap: () {
        BlocProvider.of<AccountBloc>(context)
            .add(SelectCompany(companies: state.companies, selected: current));
      },
    );
  }
}

class AddCompanyButton extends StatelessWidget {
  const AddCompanyButton({Key key}) : super(key: key);

  void showNewCompanyView(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewCompanyView();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center( 
      child:
    ButtonTheme(
      minWidth: 150,
      child: OutlineButton(
        highlightedBorderColor: Theme.of(context).accentColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () {
          showNewCompanyView(context);
        },
        child: Text(
          'Add',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 14.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    )
    );
  }
}
