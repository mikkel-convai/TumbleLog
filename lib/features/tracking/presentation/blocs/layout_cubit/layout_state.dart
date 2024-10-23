part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {
  final LayoutType layout;
  final TextType textDisplay;

  const LayoutState(this.layout, this.textDisplay);
}

class LayoutInitial extends LayoutState {
  const LayoutInitial()
      : super(LayoutType.grid, TextType.symbol); // Default initial state
}

class LayoutUpdated extends LayoutState {
  const LayoutUpdated(super.layout, super.textDisplay);
}
