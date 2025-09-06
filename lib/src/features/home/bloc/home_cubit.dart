import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenState());

  void onTapBottomNav(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void onPageChanged(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
