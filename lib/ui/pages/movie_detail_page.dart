part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("data")),
        body: FutureBuilder(
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              movieDetail = snapshot.data;
              return FutureBuilder(
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    credits = snapshot.data;
                    return Column(
                      children: <Widget>[
                        Text(movieDetail.title),
                        Text(movieDetail.genresAndLanguange),
                        Column(
                            children: credits.map((e) => Text(e.name)).toList())
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
