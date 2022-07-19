part of "widgets.dart";

class RatingStart extends StatelessWidget {
  final double voteAverage;
  final double startSize;
  final double fontSize;

  const RatingStart({this.voteAverage, this.startSize, this.fontSize});

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();

    List<Widget> widgets = List.generate(
        5,
        (index) => Icon(
              index < n ? MdiIcons.star : MdiIcons.starOutline,
              color: accentColor2,
              size: startSize,
            ));
    widgets.add(SizedBox(
      width: 3,
    ));
    widgets.add(Text("$voteAverage/10",
        style: whiteNumberFont.copyWith(
            fontWeight: FontWeight.w300, fontSize: fontSize)));

    return Row(children: widgets);
  }
}
