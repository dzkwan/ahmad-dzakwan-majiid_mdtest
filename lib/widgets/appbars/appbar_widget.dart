import 'package:fan_test/themes/light_colors.dart';
import 'package:fan_test/utils/painter_helper.dart';
import 'package:fan_test/widgets/appbars/appbar_search_widget.dart';
import 'package:fan_test/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56.0);

  AppbarWidget({
    super.key,
    required this.title,
    required this.isSearchValue,
    required this.animationController,
    required this.isSearch,
    required this.onSearch,
    // required this.ontapFilter,
    required this.onTapBack,
    this.actions,
  });

  String title;
  bool isSearchValue;
  AnimationController animationController;

  Function(bool) isSearch;
  Function(String) onSearch;
  List<Widget>? actions;
  VoidCallback onTapBack;

  @override
  _AppbarWidgetState createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget>
    with SingleTickerProviderStateMixin {
  double? rippleStartX, rippleStartY;
  Animation? _animation;

  @override
  initState() {
    super.initState();

    _animation =
        Tween(begin: 0.0, end: 1.0).animate(widget.animationController);
    widget.animationController.addStatusListener(animationStatusListener);
  }

  animationStatusListener(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      setState(() {
        widget.isSearchValue = true;
        widget.isSearch(widget.isSearchValue);
      });
    }
  }

  void onSearchTapUp(TapUpDetails details) {
    setState(() {
      rippleStartX = details.globalPosition.dx;
      rippleStartY = details.globalPosition.dy;
    });

    print("pointer location $rippleStartX, $rippleStartY");
    widget.animationController.forward();
  }

  cancelSearch() {
    setState(() {
      widget.isSearchValue = false;
      widget.isSearch(widget.isSearchValue);
      widget.onTapBack();
    });

    widget.animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        AppBar(
          titleSpacing: 0,
          elevation: 0,
          titleTextStyle: TextStyle(fontFamily: "Rubik"),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: TextMediumBold(
                  value: "${widget.title}",
                  letterSpacing: 1,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.search_rounded,
                            color: LightColors.white,
                          ),
                        ),
                        onTapUp: onSearchTapUp,
                      ),
                    ),
                    if (widget.actions != null) ...[
                      ...widget.actions!,
                    ],
                    // Material(
                    //   color: Colors.transparent,
                    //   child: InkWell(
                    //     borderRadius: BorderRadius.circular(50),
                    //     child: Container(
                    //       padding: EdgeInsets.all(13),
                    //       child: Image.asset(
                    //         "assets/images/filter-icon.png",
                    //         scale: 3,
                    //       ),
                    //     ),
                    //     onTap: widget.ontapFilter,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedBuilder(
          animation: _animation!,
          builder: (context, child) {
            return CustomPaint(
              painter: SearchPainter(
                containerHeight: widget.preferredSize.height,
                center: Offset(rippleStartX ?? 0, rippleStartY ?? 0),
                radius: _animation!.value * screenWidth,
                context: context,
              ),
            );
          },
        ),
        widget.isSearchValue
            ? AppbarSearchWidget(
                onCancelSearch: cancelSearch,
                onSearchQueryChanged: widget.onSearch,
              )
            : Container()
      ],
    );
  }
}
