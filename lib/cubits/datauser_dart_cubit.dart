import 'package:bloc/bloc.dart';
import 'package:parentoday_ai/models/data_user.dart';

import '../models/api_return_data.dart';
import '../services/datauser_services.dart';
import 'datauser_dart_state.dart';

class DataUserCubit extends Cubit<DataUserState> {
  DataUserCubit() : super(DataUserInitial());

  Future<void> getData(String token) async {
    ApiReturnData<List<DataUser>>? result =
        await DataUserServices.getData(token);
    if (result?.value != null) {
      emit(DataUserLoaded(dataUser: result?.value));
    } else {
      emit(DataUserLoadingFailed(result?.message));
    }
  }
}
