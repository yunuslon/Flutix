part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(color: Colors.white),
          SafeArea(
            child: Container(
              color: Colors.white,
            ),
          ),
          ListView(
            children: <Widget>[
              //* note: Back Icon
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20, left: defaultMargin),
                    padding: EdgeInsets.all(1),
                    child: GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToMainPage());
                        },
                        child: Icon(Icons.arrow_back, color: Colors.black)),
                  ),
                  SizedBox(
                    height: 178,
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) {
                        if (userState is UserLoaded) {
                          return Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:
                                              (userState.user.profilePicture ==
                                                      "")
                                                  ? AssetImage(
                                                      "assets/user_pic.png")
                                                  : NetworkImage(userState
                                                      .user.profilePicture),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 8),
                                  child: Text(userState.user.name,
                                      style: blackTextFont.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Container(
                                  child: Text(userState.user.email,
                                      style:
                                          greyTextFont.copyWith(fontSize: 16)),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SpinKitFadingCircle(
                            color: accentColor2,
                            size: 50,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                      onTap: () {},
                      child: itemProfile(
                          context, "edit_profile.png", "Edit Profile")),
                  itemProfile(context, "my_wallet.png", "My Wallet"),
                  itemProfile(context, "language.png", "Change Language"),
                  itemProfile(context, "help_center.png", "Help Centre"),
                  itemProfile(context, "rate.png", "Rate Flutix App"),
                  Center(
                    child: Container(
                      width: 250,
                      height: 46,
                      margin: EdgeInsets.only(top: 36, bottom: 50),
                      child: RaisedButton(
                        elevation: 0,
                        color: mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Text("Sign Out",
                            style: whiteTextFont.copyWith(fontSize: 16)),
                        onPressed: () {
                          context.bloc<UserBloc>().add(SignOut());
                          AuthServices.signOut();
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      )),
    );
  }

  Container itemProfile(BuildContext context, String icon, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/${icon}")))),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  label,
                  style: blackTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ))
          ]),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: generateDashedDivider(
                MediaQuery.of(context).size.width - 2 * defaultMargin),
          ),
          SizedBox(height: defaultMargin)
        ],
      ),
    );
  }
}
