import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  final Function? onTap;
  final Widget? child;

  const OverlayWidget({
    super.key,
    this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            minWidth: constraints.maxWidth,
          ),
          child: GestureDetector(
            onTap: () => {}, //onTap,
            child: Material(
              color: Colors.black.withOpacity(.5),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 150,
                  ),
                  child: Center(child: child),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
