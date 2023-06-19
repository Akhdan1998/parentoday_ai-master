import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';
import '../services/services.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AiCubit() : super(AiInitial());

  Future<void> getAi(String token, String random_id) async {
    ApiReturnValue<List<Ai>>? result = await AiServices.getAi(token, random_id);
    if (result?.value != null) {
      emit(AiLoaded(ai: result?.value));
    } else {
      emit(AiLoadingFailed(result?.message));
    }
  }
}
