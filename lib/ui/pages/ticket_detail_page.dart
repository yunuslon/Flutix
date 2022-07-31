part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  const TicketDetailPage(this.ticket);

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
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 22, bottom: 20),
                    height: 56,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToMainPage());
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Ticket Details",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 120,
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              image: DecorationImage(
                                  image: NetworkImage(imageBaseURL +
                                      'w780' +
                                      ticket.movieDetail.backdropPath),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 16, top: 16, right: 16, bottom: 6),
                          child: Text(ticket.movieDetail.title,
                              style: blackTextFont.copyWith(fontSize: 18)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            ticket.movieDetail.genresAndLanguange,
                            style: greyTextFont.copyWith(fontSize: 12),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                left: 16, top: 6, right: 16, bottom: 8),
                            height: 20,
                            child: RatingStart(
                                voteAverage: ticket.movieDetail.voteAverage)),
                        labelDetail('Cinema', ticket.theater.name, context),
                        labelDetail(
                            'Date & Time', ticket.time.dateAndTime, context),
                        labelDetail(
                            'Seat Number', ticket.seatsInString, context),
                        labelDetail('ID Order', ticket.bookingCode, context),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: generateDashedDivider(
                              MediaQuery.of(context).size.width / 2 +
                                  defaultMargin * 2 +
                                  44),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Name",
                                      style:
                                          greyTextFont.copyWith(fontSize: 16)),
                                  Text(ticket.name,
                                      style:
                                          blackTextFont.copyWith(fontSize: 16)),
                                  SizedBox(height: 8),
                                  Text("Paid",
                                      style:
                                          greyTextFont.copyWith(fontSize: 16)),
                                  Text(
                                      NumberFormat.currency(
                                        locale: 'id_ID',
                                        decimalDigits: 0,
                                        symbol: 'Rp ',
                                      ).format(ticket.totalPrice),
                                      style: whiteNumberFont.copyWith(
                                          fontSize: 16, color: Colors.black)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 18),
                              child: Center(
                                child: QrImage(
                                  data: ticket.bookingCode,
                                  version: 3,
                                  errorCorrectionLevel: QrErrorCorrectLevel.M,
                                  padding: EdgeInsets.all(16),
                                  size: 120,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container labelDetail(String label, String value, context) => Container(
        margin: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 -
                  defaultMargin * 2 -
                  32,
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: greyTextFont.copyWith(fontSize: 16),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 -
                  defaultMargin * 2 -
                  16,
              child: Text(value,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.right,
                  style: blackTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      );
}
