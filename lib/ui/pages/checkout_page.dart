part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  const CheckoutPage(this.ticket);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int total = 26500 * widget.ticket.seats.length;

    return WillPopScope(
      onWillPop: () async {
        context.bloc().add(GoToSelectSeatPage(widget.ticket));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(color: accentColor1),
            SafeArea(child: Container(color: Colors.white)),
            ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20, left: defaultMargin),
                          padding: EdgeInsets.all(1),
                          child: GestureDetector(
                              onTap: () {
                                context
                                    .bloc<PageBloc>()
                                    .add(GoToSelectSeatPage(widget.ticket));
                              },
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black)),
                        ),
                      ],
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) {
                        User user = (userState as UserLoaded).user;

                        return Column(
                          children: <Widget>[
                            //* note: page title
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "Checkout\nMovie",
                                style: blackTextFont.copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            //* note: movie description
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 70,
                                  height: 90,
                                  margin: EdgeInsets.only(
                                      left: defaultMargin, right: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(imageBaseURL +
                                              'w342' +
                                              widget.ticket.movieDetail
                                                  .posterPath),
                                          fit: BoxFit.cover)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          70 -
                                          20,
                                      child: Text(
                                        widget.ticket.movieDetail.title,
                                        style: blackTextFont.copyWith(
                                            fontSize: 18),
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          2 * defaultMargin -
                                          70 -
                                          20,
                                      child: Text(
                                        widget.ticket.movieDetail
                                            .genresAndLanguange,
                                        style: greyTextFont.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    RatingStart(
                                      voteAverage:
                                          widget.ticket.movieDetail.voteAverage,
                                      color: accentColor3,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: defaultMargin),
                              child: Divider(
                                color: Color(0xffe4e4e4),
                                thickness: 1,
                              ),
                            ),
                            labelText(
                                context, "Order ID", widget.ticket.bookingCode),
                            SizedBox(height: 9),
                            labelText(
                                context, "Cinema", widget.ticket.theater.name),
                            SizedBox(height: 9),
                            labelText(context, "Date & Time",
                                widget.ticket.time.dateAndTime),
                            SizedBox(height: 9),
                            labelText(context, "Seat Numbers",
                                widget.ticket.seatsInString),
                            SizedBox(height: 9),
                            labelText(
                              context,
                              "Price",
                              "IDR 25.000 x ${widget.ticket.seats.length}",
                            ),
                            SizedBox(height: 9),
                            labelText(context, "Fee",
                                "IDR 1.500 x ${widget.ticket.seats.length}"),
                            SizedBox(height: 9),
                            labelText(
                                context,
                                "Total",
                                NumberFormat.currency(
                                  locale: 'id_ID',
                                  decimalDigits: 0,
                                  symbol: 'IDR ',
                                ).format(total),
                                weightSty: FontWeight.w600,
                                clr: Colors.black),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: defaultMargin),
                              child: Divider(
                                color: Color(0xffe4e4e4),
                                thickness: 1,
                              ),
                            ),
                            SizedBox(height: 9),
                            labelText(
                                context,
                                "Your Wallet",
                                NumberFormat.currency(
                                  locale: 'id_ID',
                                  decimalDigits: 0,
                                  symbol: 'IDR ',
                                ).format(user.balance),
                                weightSty: FontWeight.w600,
                                clr: (user.balance >= total)
                                    ? Color(0xff3e9d9d)
                                    : Color(0xffff5c83)),
                            Container(
                              width: 250,
                              height: 46,
                              margin: EdgeInsets.only(top: 36, bottom: 50),
                              child: RaisedButton(
                                elevation: 0,
                                color: user.balance >= total
                                    ? Color(0xff3e9d9d)
                                    : mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                    (user.balance >= total)
                                        ? "Checkout Now"
                                        : "Top Up My Wallet",
                                    style:
                                        whiteTextFont.copyWith(fontSize: 16)),
                                onPressed: () {
                                  if (user.balance >= total) {
                                    FlutixTransaction transaction =
                                        FlutixTransaction(
                                            userID: user.id,
                                            title:
                                                widget.ticket.movieDetail.title,
                                            subtitle:
                                                widget.ticket.theater.name,
                                            time: DateTime.now(),
                                            amount: -total,
                                            picture: widget
                                                .ticket.movieDetail.posterPath);

                                    context.bloc<PageBloc>().add(
                                        GoToSuccessPage(
                                            widget.ticket
                                                .copyWith(totalPrice: total),
                                            transaction));
                                  } else {
                                    //! Uang Tidak Cukup
                                  }
                                },
                              ),
                            )
                          ],
                        );
                      },
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding labelText(BuildContext context, String label, String value,
      {Color clr, FontWeight weightSty}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: greyTextFont.copyWith(
                fontSize: 16, fontWeight: FontWeight.w400),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: whiteNumberFont.copyWith(
                    color: clr ?? Colors.black,
                    fontSize: 16,
                    fontWeight: weightSty ?? FontWeight.w400),
              ))
        ],
      ),
    );
  }
}
