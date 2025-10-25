import 'package:equatable/equatable.dart';
import '../model/grade_model.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get list => [];
}

class LoadMovieEvent extends MovieEvent {}

class UpdateMovieEvent extends MovieEventEvent {
  final MovieModel grade;
  UpdateGradeEvent(this.grade);
  @override
  List<Object?> get props => [grade];
}
class RefreshMovieList extends MovieEvent {}
