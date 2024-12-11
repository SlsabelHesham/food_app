import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends SearchState {}

class LoadedState extends SearchState {
    final String type;
  final List<Map<String, dynamic>> restaurants;

  LoadedState({required this.type, required this.restaurants});

  @override
  List<Object> get props => [restaurants];
}

class ErrorState extends SearchState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
