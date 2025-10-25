import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart.dart';
import 'movie_event.dart_event.dart';
import 'movie_event.dart_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  static const String prefsKey = 'movie_data;

  MovieBloc() : super(MovieState(movie: MovieModel())) {
    on<LoadMovie>(_onLoad);
    on<UpdateMovie>(_onUpdate);
    on<ResetMovie>(_onReset);
  }

  Future<void> _onLoad(LoadGradesEvent event, Emitter<GradeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(prefsKey);
    if (jsonString != null) {
      final data = jsonDecode(jsonString);
      emit(GradeState(grade: GradeModel.fromJson(data), result: 0));
    }
  }

  Future<void> _onUpdate(UpdateGradeEvent event, Emitter<GradeState> emit) async {
    final result = event.grade.calculateFinalGrade();
    emit(state.copyWith(grade: event.grade, result: result));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefsKey, jsonEncode(event.grade.toJson()));
  }

  Future<void> _onReset(ResetGradesEvent event, Emitter<GradeState> emit) async {
    final newGrade = GradeModel();
    emit(GradeState(grade: newGrade, result: newGrade.calculateFinalGrade()));
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(prefsKey);
  }
}
