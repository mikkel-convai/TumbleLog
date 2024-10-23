import 'package:test/test.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';

void main() {
  group('Testing layout cubit', () {
    late LayoutCubit layoutCubit;

    setUp(() {
      layoutCubit = LayoutCubit();
    });

    test('initial state is LayoutType.grid and TextType.symbol', () {
      // Verify the initial state
      expect(layoutCubit.state.layout, LayoutType.grid);
      expect(layoutCubit.state.textDisplay, TextType.symbol);
    });

    test('Testing toggleLayout', () {
      // Initial state test
      expect(layoutCubit.state.layout, LayoutType.grid);

      // Toggle layout
      layoutCubit.toggleLayout();
      expect(layoutCubit.state.layout, LayoutType.list);
      expect(layoutCubit.state.textDisplay, TextType.symbol);

      // Toggle back
      layoutCubit.toggleLayout();
      expect(layoutCubit.state.layout, LayoutType.grid);
      expect(layoutCubit.state.textDisplay, TextType.symbol);
    });

    test(
        'toggleTextDisplay switches between symbol, name, and dd while keeping layout unchanged',
        () {
      // Initial state should be symbol display
      expect(layoutCubit.state.textDisplay, TextType.symbol);

      // Toggle text display to name
      layoutCubit.toggleTextDisplay();
      expect(layoutCubit.state.textDisplay, TextType.name);

      // Ensure layout stays the same
      expect(layoutCubit.state.layout, LayoutType.grid);

      // Toggle text display to dd
      layoutCubit.toggleTextDisplay();
      expect(layoutCubit.state.textDisplay, TextType.dd);

      // Toggle back to symbol
      layoutCubit.toggleTextDisplay();
      expect(layoutCubit.state.textDisplay, TextType.symbol);
    });
  });
}
