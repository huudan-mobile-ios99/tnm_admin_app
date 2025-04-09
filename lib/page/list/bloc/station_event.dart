part of 'station_bloc.dart';

abstract class StationEvent extends Equatable {
  const StationEvent();

  @override
  List<Object?> get props => [];
}

class StationFetched extends StationEvent {}
