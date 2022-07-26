part of "pages.dart";

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSignIn = false;

  signAction(BuildContext context) async {
    if (isEmailValid && isPasswordValid) {
      setState(() {
        isSignIn = true;
      });
      SignInSingUpResult result =
          await AuthServices.signIn(emailCtr.text, passwordCtr.text);
      if (result.user == null) {
        setState(() {
          isSignIn = false;
        });
        Flushbar(
          duration: Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Color(0xffff5c83),
          message: result.message,
        )..show(context);
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(ChangeTheme(ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(primary: accentColor2))));
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSpalashPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  SizedBox(height: 70, child: Image.asset("assets/logo.png")),
                  Container(
                    margin: EdgeInsets.only(top: 70, bottom: 40),
                    child: Text("Welcome Back,\nExplorer!",
                        style: blackTextFont.copyWith(fontSize: 20)),
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    controller: emailCtr,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Email Addres",
                      hintText: "Email Addres",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    controller: passwordCtr,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Password",
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(children: <Widget>[
                    Text("Forgot Password? ",
                        style: greyTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                    Text("Get Now",
                        style: purpelTextFont.copyWith(fontSize: 12)),
                  ]),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 40, bottom: 30),
                      child: isSignIn
                          ? SpinKitFadingCircle(
                              color: mainColor,
                            )
                          : FloatingActionButton(
                              elevation: 0,
                              child: Icon(
                                Icons.arrow_forward,
                                color: isEmailValid && isPasswordValid
                                    ? Colors.white
                                    : Color(0xffbebebe),
                              ),
                              backgroundColor: isEmailValid && isPasswordValid
                                  ? mainColor
                                  : Color(0xffe4e4e4),
                              onPressed: () => signAction(context)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Start Fresh Now? ",
                        style:
                            greyTextFont.copyWith(fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .bloc<PageBloc>()
                              .add(GoToRegistrationPage(RegistrationData()));
                        },
                        child: Text(
                          "Sign Up",
                          style: (purpelTextFont),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
