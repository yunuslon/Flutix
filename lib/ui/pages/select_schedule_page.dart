part of 'pages.dart';

class SelectSchedulPage extends StatefulWidget {
  final MovieDetail movieDetail;

  const SelectSchedulPage(this.movieDetail);

  @override
  State<SelectSchedulPage> createState() => _SelectSchedulPageState();
}

class _SelectSchedulPageState extends State<SelectSchedulPage> {
  List<DateTime> dates;
  DateTime selectedDate;

  void initState() {
    super.initState();

    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc().add(GoToMovieDetailPage(widget.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: accentColor1),
            SafeArea(
                child: Container(
              color: Colors.white,
            )),
            ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.94)),
                      child: GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToMovieDetailPage(widget.movieDetail));
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white)),
                    ),
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
                  child: Text(
                    "Choose Date",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dates.length,
                    itemBuilder: (_, i) => Container(
                        margin: EdgeInsets.only(
                            left: (i == 0) ? defaultMargin : 0,
                            right: (i < dates.length - 1) ? 16 : defaultMargin),
                        child: DateCard(
                          dates[i],
                          isSelected: selectedDate == dates[i],
                          onTap: () {
                            setState(() {
                              selectedDate = dates[i];
                            });
                          },
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
