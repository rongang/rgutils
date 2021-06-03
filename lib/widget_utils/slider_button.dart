import 'package:flutter/material.dart';

class SliderButton extends StatefulWidget {
  final Widget? child, button1, button2, button3;

  SliderButton({
    Key? key,
    this.child,
    this.button1,
    this.button2,
    this.button3,
  }) : super(key: key);


  @override
  _SliderButtonState createState() => _SliderButtonState();
}

class _SliderButtonState extends State<SliderButton> {
  ScrollController scrollController = ScrollController();
  late double offset;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      offset = scrollController.offset;
    });
  }

  open() {
    scrollController.animateTo(200,
        duration: Duration(milliseconds: 250), curve: Curves.linearToEaseOut);
  }

  close() {
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 250), curve: Curves.linearToEaseOut);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return LayoutBuilder(builder: (ctx, box) {
      // print('$box');
      return Container(
        width: size.width,
        // height: 400,
        child: Listener(
          onPointerUp: (value) {
            if (offset < 50) return;
            // print('${scrollController.position.physics}');
            if (offset < 100) {
              close();
            } else if (offset > 100) {
              open();
            }
          },
          child: ScrollConfiguration(
            behavior: HideSlideSplash(),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: size.width,
                      color: Colors.deepOrange,
                      child: widget.child,
                    ),
                    Container(
                      width: 100,
                      // height: double.infinity,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: widget.button1,
                    ),
                    Container(
                      width: 100,
                      // height: double.infinity,
                      color: Colors.lightBlue,
                      alignment: Alignment.center,
                      child: widget.button2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class HideSlideSplash extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          showLeading: false,
          showTrailing: false,
          axisDirection: axisDirection,
          color: Colors.transparent,
        );
    }
  }
}
