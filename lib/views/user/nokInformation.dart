import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/components/cards/userInfoCard.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/smallText.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './editNok.dart';

class NokInformation extends StatefulWidget {
  static String tag = 'NokInformation';
  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<NokInformation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SmallText('Next Of Kin Information', altThemeColor),
                SizedBox(height: normalspacing),
                UserInfoCard(
                  tertiaryColor,
                  'First Name',
                  authBloc.authUser['user']['nokFirstName'] != null
                      ? '${authBloc.authUser['user']['nokFirstName']}'
                      : 'Not Set',
                  Icons.person,
                ),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'Last Name',
                  authBloc.authUser['user']['nokLastName'] != null
                      ? '${authBloc.authUser['user']['nokLastName']}'
                      : 'Not Set',
                  Icons.person,
                ),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'Phone Number',
                  authBloc.authUser['user']['nokPhoneNumber'] != null
                      ? '${authBloc.authUser['user']['nokPhoneNumber']}'
                      : 'Not Set',
                  Icons.phone,
                ),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'Gender',
                  authBloc.authUser['user']['nokGender'] != null
                      ? '${authBloc.authUser['user']['nokGender']}'
                      : 'Not Set',
                  Icons.person,
                ),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'Address',
                  authBloc.authUser['user']['nokAddress'] != null
                      ? '${authBloc.authUser['user']['nokAddress']}'
                      : 'Not Set',
                  Icons.location_city_sharp,
                ),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'City',
                  authBloc.authUser['user']['nokCity'] != null
                      ? '${authBloc.authUser['user']['nokCity']}'
                      : 'Not Set',
                  Icons.location_city,
                ),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'State',
                  authBloc.authUser['user']['nokState'] != null
                      ? '${authBloc.authUser['user']['nokState']}'
                      : 'Not Set',
                  Icons.location_city_sharp,
                ),
                SizedBox(height: minorspacing),
                SizedBox(height: largespacing),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minWidth: 200.0,
                  height: 50.0,
                  onPressed: () {
                    Navigator.pushNamed(context, EditNok.tag);
                  },
                  color: altThemeColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Edit Profile',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.edit, color: appBackgroundColor)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
