part of 'pages.dart';

class AccountConfimationPage extends StatefulWidget {
  final RegistrationData registrationData;

  const AccountConfimationPage(this.registrationData);

  @override
  State<AccountConfimationPage> createState() => _AccountConfimationPageState();
}

class _AccountConfimationPageState extends State<AccountConfimationPage> {
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context
            .bloc<PageBloc>()
            .add(GoToPreferencePage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 90),
                    height: 56,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GoToPreferencePage(widget.registrationData));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Confirm\nNew Account",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                (widget.registrationData.profileImage == null)
                                    ? AssetImage("assets/user_pic.png")
                                    : FileImage(
                                        widget.registrationData.profileImage),
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    "Welcome",
                    style: blackTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "${widget.registrationData.name}",
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 110),
                  (isSigningUp)
                      ? SpinKitFadingCircle(
                          color: Color(0xff3e9d9d),
                          size: 45,
                        )
                      : SizedBox(
                          width: 250,
                          height: 45,
                          child: RaisedButton(
                            color: Color(0xff3e9d9d),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Create My Account",
                              style: whiteNumberFont.copyWith(fontSize: 16),
                            ),
                            onPressed: () async {
                              setState(() {
                                isSigningUp = true;
                              });

                              imageFileToUpload =
                                  widget.registrationData.profileImage;

                              SignInSingUpResult result =
                                  await AuthServices.signUp(
                                      widget.registrationData.email,
                                      widget.registrationData.password,
                                      widget.registrationData.name,
                                      widget.registrationData.selectedGenres,
                                      widget.registrationData.selectedLang);
                              print(result);

                              if (result.user == null) {
                                setState(() {
                                  isSigningUp = false;
                                });

                                Flushbar(
                                  duration: Duration(seconds: 2),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xffff5c83),
                                  message: result.message,
                                )..show(context);
                              }
                            },
                          ),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
