import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/modules/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void minusCounter() {
    counter--;
    emit(CounterMinusState());
  }

  void addCounter() {
    counter++;
    emit(CounterPlusState());
  }
}
