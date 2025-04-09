// Updated TabState
import 'package:flutter_bloc/flutter_bloc.dart';


// Events
abstract class TabEvent {}

class TabChangedEvent extends TabEvent {
  final int tabIndex;
  TabChangedEvent(this.tabIndex);
}



class TabState {
  final int selectedIndex;
  final List<bool> isActive;

  TabState({required this.selectedIndex, required this.isActive});

  // Helper to update active states
  TabState copyWith({int? selectedIndex, List<bool>? isActive}) {
    return TabState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isActive: isActive ?? this.isActive,
    );
  }
}

// Updated Bloc
class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabState(
          selectedIndex: 0,
          isActive: [true, false,false], // Default: first tab active
        ));

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    if (event is TabChangedEvent) {
      final newActive = List<bool>.filled(state.isActive.length, false);
      newActive[event.tabIndex] = true; // Set active tab

      yield state.copyWith(
        selectedIndex: event.tabIndex,
        isActive: newActive,
      );
    }
  }
}
