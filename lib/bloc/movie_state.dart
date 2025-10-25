import 'package:equatable/equatable.dart';
import '../model/grade_model.dart';

class MovieState extends Equatable {
  final MovieModel movieName;
  final double movieDetails;

  const Movietate({
    required this.grade,
    this.result = 100.0,
  });

  GradeState copyWith({
    MovieModel grade,
    double? result,
  }) =>
      MovieModelState(
        grade: grade ?? this.grade,
        result: result ?? this.result,
      );

  @override
  List<Object?> get props => [grade, result];
}