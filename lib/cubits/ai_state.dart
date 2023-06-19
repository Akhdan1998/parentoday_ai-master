part of 'ai_cubit.dart';

abstract class AiState extends Equatable {
  const AiState();

  @override
  List<Object> get props => [];
}

class AiInitial extends AiState {

}

class AiLoaded extends AiState {
  final List<Ai>? ai;

  AiLoaded({this.ai});

  @override
  List<Object> get props => [ai!];
}

class AiLoadingFailed extends AiState {
  final String? message;

  AiLoadingFailed(this.message);

  @override
  List<Object> get props => [message!];
}
