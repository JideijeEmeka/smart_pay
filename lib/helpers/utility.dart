import 'package:flutter/material.dart';
import 'package:smartpay/helpers/constants.dart';
import 'package:smartpay/widgets/over_lay_widget.dart';

class Utility {

  static Widget loader(
      {double width = 25, double height = 25, Color? bgColor}) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
          strokeWidth: 2.1,
          valueColor:
          AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.9)),
          backgroundColor: bgColor ??
              mainColor
                  .withOpacity(0.7)),
    );
  }

  static OverlayEntry showOverlay(BuildContext context, Widget child) {
    OverlayEntry entry =
    OverlayEntry(opaque: false, builder: (BuildContext context) => child);
    Overlay.of(context).insert(entry);
    return entry;
  }

  static load(BuildContext context, {String message = "Please wait..."}) {
    return showOverlay(
      context,
      OverlayWidget(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    mainColor.withOpacity(0.7),
                  ),
                  backgroundColor: Colors.white70,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                message,
                style: TextStyle(
                    color: mainColor
                        .withOpacity(0.7),
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}