import 'package:flutter_bloc/flutter_bloc.dart';

class PanelCubit extends Cubit<int> {
  PanelCubit() : super(0);

  setPanel(int index) => emit(index);

  getPanel() => state;
}
