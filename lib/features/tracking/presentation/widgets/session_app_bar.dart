import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumblelog/constants.dart';
import 'package:tumblelog/features/tracking/presentation/blocs/layout_cubit/layout_cubit.dart';

class SessionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SessionAppBar({
    super.key,
  });

  String getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('MMMM d, yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return AppBar(
          title: Text(getCurrentDate()),
          actions: [
            // Toggle button for layout
            IconButton(
              icon: Icon(
                state.layout == LayoutType.grid ? Icons.grid_on : Icons.list,
              ),
              onPressed: () => context.read<LayoutCubit>().toggleLayout(),
              tooltip: "Toggle Layout",
            ),

            // Toggle button for text size
            IconButton(
              icon: Icon(
                state.textDisplay == TextType.symbol
                    ? Icons.text_fields
                    : state.textDisplay == TextType.name
                        ? Icons.person
                        : Icons.list_alt, // DD display
              ),
              onPressed: () => context.read<LayoutCubit>().toggleTextDisplay(),
              tooltip: "Toggle Text Size",
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
