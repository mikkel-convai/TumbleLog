import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(const LayoutInitial());

  // Toggle the layout between grid and list
  void toggleLayout() {
    final newLayout =
        state.layout == LayoutType.grid ? LayoutType.list : LayoutType.grid;
    emit(LayoutUpdated(
        newLayout, state.textDisplay)); // Keep the same textDisplay state
  }

  // Toggle the text display type between symbol, name, and dd
  void toggleTextDisplay() {
    TextType newText;
    if (state.textDisplay == TextType.symbol) {
      newText = TextType.name;
    } else if (state.textDisplay == TextType.name) {
      newText = TextType.dd;
    } else {
      newText = TextType.symbol;
    }
    emit(LayoutUpdated(state.layout, newText)); // Keep the same layout state
  }
}
