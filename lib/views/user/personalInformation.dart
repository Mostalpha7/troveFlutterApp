import 'package:troveapp/bloc/authBloc.dart';
import 'package:troveapp/components/cards/userInfoCard.dart';
import 'package:troveapp/components/theme/color.dart';
import 'package:troveapp/components/theme/sizes.dart';
import 'package:troveapp/components/typography/smallText.dart';
import 'package:troveapp/views/user/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileInformation extends StatefulWidget {
  static String tag = 'ProfileInformation';
  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
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
                SmallText('PERSONAL INFOMATION', altThemeColor),
                SizedBox(height: normalspacing),
                UserInfoCard(
                  tertiaryColor,
                  'Fullname',
                  '${authBloc.authUser['user']['firstName']}' +
                      ' ' +
                      '${authBloc.authUser['user']['lastName']}',
                  Icons.person,
                ),
                SizedBox(height: minorspacing),
                UserInfoCard(tertiaryColor, 'E-mail',
                    '${authBloc.authUser['user']['email']}', Icons.person),
                SizedBox(height: minorspacing),
                UserInfoCard(tertiaryColor, 'Phone Number',
                    '${authBloc.authUser['user']['phoneNumber']}', Icons.phone),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'Phone Number2',
                  authBloc.authUser['user']['phoneNumber2'] != null
                      ? '${authBloc.authUser['user']['phoneNumber2']}'
                      : 'Not Set',
                  Icons.phone,
                ),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'Gender',
                  authBloc.authUser['user']['gender'] != null
                      ? '${authBloc.authUser['user']['gender']}'
                      : 'Not Set',
                  Icons.person,
                ),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'Address',
                  authBloc.authUser['user']['address'] != null
                      ? '${authBloc.authUser['user']['address']}'
                      : 'Not Set',
                  Icons.location_city_sharp,
                ),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'City',
                  authBloc.authUser['user']['city'] != null
                      ? '${authBloc.authUser['user']['city']}'
                      : 'Not Set',
                  Icons.location_city,
                ),
                SizedBox(height: minorspacing),
                SizedBox(height: minorspacing),
                UserInfoCard(
                  tertiaryColor,
                  'State',
                  authBloc.authUser['user']['state'] != null
                      ? '${authBloc.authUser['user']['state']}'
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(),
                      ),
                    );
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
