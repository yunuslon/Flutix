part of "pages.dart";

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSpalashPage)) {
        prevPageEvent = GoToSpalashPage();
        context.bloc<PageBloc>().add(GoToSpalashPage());
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(GoToMainPage());
      }
    }

    pageAction(pageState) {
      if (pageState is OnSplahPage) {
        return SplashPage();
      } else if (pageState is OnLoginPage) {
        return SignInPage();
      } else if (pageState is OnRegistrationPage) {
        return SignUpPage(pageState.registrationData);
      } else if (pageState is OnPreferencePage) {
        return PreferencePage(pageState.registrationData);
      } else if (pageState is OnAccountConfirmationPage) {
        return AccountConfimationPage(pageState.registrationData);
      } else if (pageState is OnMovieDetailPage) {
        return MovieDetailPage(pageState.movie);
      } else {
        return MainPage();
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => pageAction(pageState));
  }
}
