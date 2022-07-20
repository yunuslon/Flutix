part of "widgets.dart";

class ComingSoonCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;
  ComingSoonCard(this.movie, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(imageBaseURL + "w500" + movie.backdropPath),
              fit: BoxFit.cover)),
      child: Container(
        width: 100,
        height: 140,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.61),
                  Colors.black.withOpacity(0)
                ])),
      ),
    );
  }
}
