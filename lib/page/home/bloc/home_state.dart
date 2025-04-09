import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final int jackpotValue;
  final int machineId;
  final String createdAt;

  const HomeState({
    required this.jackpotValue,
    required this.machineId,
    required this.createdAt,
  });

  // Initial state
  factory HomeState.initial() {
    return const HomeState(
      jackpotValue: 0,
      machineId: 0,
      createdAt: '',
    );
  }

  @override
  List<Object> get props => [jackpotValue, machineId, createdAt];

  // CopyWith method for updating state
  HomeState copyWith({
    int? jackpotValue,
    int? machineId,
    String? createdAt,
  }) {
    return HomeState(
      jackpotValue: jackpotValue ?? this.jackpotValue,
      machineId: machineId ?? this.machineId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
