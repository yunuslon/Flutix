part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController retypePasswordCtr = TextEditingController();
  bool passShow = true;

  @override
  void initState() {
    super.initState();
    nameCtr.text = widget.registrationData.name;
    emailCtr.text = widget.registrationData.email;
  }

  validateAction(BuildContext context) {
    if (!(nameCtr.text.trim() != "" &&
        emailCtr.text.trim() != "" &&
        passwordCtr.text.trim() != "" &&
        retypePasswordCtr.text.trim() != "")) {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xffff5c83),
        message: "Please fill all the fields",
      ).show(context);
    } else if (passwordCtr.text != retypePasswordCtr.text) {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xffff5c83),
        message: "Mismatch password and confirmed password",
      ).show(context);
    } else if (passwordCtr.text.length < 6) {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xffff5c83),
        message: "Password's length min 6 characters",
      ).show(context);
    } else if (!EmailValidator.validate(emailCtr.text)) {
      Flushbar(
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xffff5c83),
        message: "Wrong formatted email address",
      ).show(context);
    } else {
      widget.registrationData.name = nameCtr.text;
      widget.registrationData.email = emailCtr.text;
      widget.registrationData.password = passwordCtr.text;

      context.bloc<PageBloc>().add(GoToPreferencePage(widget.registrationData));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(primary: accentColor1))));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSpalashPage());
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Create New\nAccount",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 104,
                    width: 90,
                    child: Stack(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (widget
                                              .registrationData.profileImage ==
                                          null)
                                      ? AssetImage("assets/user_pic.png")
                                      : FileImage(
                                          widget.registrationData.profileImage),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationData.profileImage ==
                                  null) {
                                widget.registrationData.profileImage =
                                    await getImage();
                              } else {
                                widget.registrationData.profileImage = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage((widget.registrationData
                                                  .profileImage ==
                                              null)
                                          ? "assets/btn_add_photo.png"
                                          : "assets/btn_del_photo.png"))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 36),
                  TextField(
                    controller: nameCtr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Full Name",
                        hintText: "Full Name"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: emailCtr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Email",
                        hintText: "Email"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: passwordCtr,
                    obscureText: passShow,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                passShow = !passShow;
                              });
                            },
                            child: Icon(
                                (passShow) ? MdiIcons.eye : MdiIcons.eyeOff)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Password",
                        hintText: "Password"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: retypePasswordCtr,
                    obscureText: passShow,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                passShow = !passShow;
                              });
                            },
                            child: Icon(
                                (passShow) ? MdiIcons.eye : MdiIcons.eyeOff)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Confirm Password",
                        hintText: "Confirm Password"),
                  ),
                  SizedBox(height: 30),
                  FloatingActionButton(
                    child: Icon(Icons.arrow_forward),
                    backgroundColor: mainColor,
                    elevation: 0,
                    onPressed: () => validateAction(context),
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
