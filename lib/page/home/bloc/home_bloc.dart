import 'package:bloc/bloc.dart';
import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.initial());

  // Save jackpot data
  void saveJackpotData({
    required int jackpotValue,
    required int machineId,
    required String createdAt,
  }) {
    emit(
      state.copyWith(
        jackpotValue: jackpotValue,
        machineId: machineId,
        createdAt: createdAt,
      ),
    );
  }

  // Retrieve jackpot data
  HomeState getJackpotData() {
    return state;
  }
}
