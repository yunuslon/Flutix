part of 'models.dart';

class MovieDetail extends Movie {
  final List<String> genres;
  final String languange;

  MovieDetail(Movie movie, {this.genres, this.languange})
      : super(
            id: movie.id,
            title: movie.title,
            voteAverage: movie.voteAverage,
            overView: movie.overView,
            posterPath: movie.posterPath,
            backdropPath: movie.backdropPath);

  String get genresAndLanguange {
    String s = "";
    for (var genre in genres) {
      s += genre + (genre != genres.last ? ', ' : '');
    }

    return "$s - $languange";
  }

  @override
  List<Object> get props => super.props + [genres, languange];
}
