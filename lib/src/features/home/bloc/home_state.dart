part of 'home_cubit.dart';

class HomeScreenState extends Equatable {
  final int selectedIndex;

  const HomeScreenState({
    this.selectedIndex = 0,
  });

  HomeScreenState copyWith({
    int? selectedIndex,
  }) {
    return HomeScreenState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}
