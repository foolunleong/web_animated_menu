import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'menu_tiles_widget.dart';
import '../model/sub_menu.dart';
import '../utils/animation_type.dart';
import '../utils/header_position.dart';
import '../model/menu.dart';

class AnimatedHoverMenu extends StatefulWidget {
  ///Header properties
  final List<Menu> headerTiles;
  final BoxDecoration? headerBoxDecoration;
  final BoxDecoration? headerBoxDecorationSelected;
  final Color? headerTextColor;
  final Color? headerTextColorSelected;
  final double? headerTextSize;

  ///Menu properties
  final List<List<SubMenu>> menuTiles;
  final BoxDecoration? menuBoxDecoration;
  final Color? menuTextColor;
  final double? menuTextSize;

  ///The type of animation
  final AnimationType? animationType;

  ///Header menu position
  final HeaderPosition headerPosition;

  ///Background gradient
  final Widget? backgroundWidget;

  ///Current route
  final String? selectedRoute;

  AnimatedHoverMenu({
    Key? key,
    required this.headerTiles,
    required this.menuTiles,
    required this.headerPosition,
    this.backgroundWidget,
    this.headerBoxDecoration,
    this.headerBoxDecorationSelected,
    this.headerTextColor,
    this.headerTextColorSelected,
    this.headerTextSize,
    this.menuBoxDecoration,
    this.menuTextColor,
    this.menuTextSize,
    this.animationType,
    this.selectedRoute,
  }) : super(key: key);

  @override
  _AnimatedHoverMenuState createState() => _AnimatedHoverMenuState();
}

class _AnimatedHoverMenuState extends State<AnimatedHoverMenu> with SingleTickerProviderStateMixin {
  bool hovered = false;
  ValueNotifier<int?> selectedSubMenu = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: MouseRegion(
        opaque: true,
        onEnter: (PointerEnterEvent pointerEnterEvent) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (PointerExitEvent pointerExitEvent) {
          setState(() {
            hovered = false;
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: widget.backgroundWidget ??
                  Container(
                    color: Colors.white,
                  ),
            ),
            _headerMenuWidget(widget.selectedRoute),
          ],
        ),
      ),
    );
  }

  ///It will return header menu list
  Widget _headerMenuWidget(String? selectedRoute) {
    return Container(
      alignment: Alignment.center,
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.headerTiles.length,
        shrinkWrap: widget.headerPosition == HeaderPosition.topLeft ? false : true,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: MenuTilesWidget(
              menuTiles: widget.menuTiles[index],
              headerTiles: widget.headerTiles,
              index: index,
              hovered: hovered,
              menuBoxDecoration: widget.menuBoxDecoration ??
                  const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7.0),
                      ),
                      color: Colors.black38),
              menuTextColor: widget.menuTextColor ?? Colors.white,
              menuTextSize: widget.menuTextSize ?? 16.0,
              headerPosition: widget.headerPosition,
              animationType: widget.animationType ?? AnimationType.leftToRight,
              child: InkWell(
                onTap: widget.headerTiles[index].onTap,
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: (widget.headerTiles[index].route == selectedRoute)
                      ? widget.headerBoxDecorationSelected
                      : widget.headerBoxDecoration ??
                          const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                              color: Colors.black),
                  alignment: Alignment.center,
                  child: Text(
                    widget.headerTiles[index].name ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: widget.headerTextSize ?? 15.0,
                        fontWeight: FontWeight.w500,
                        color: (widget.headerTiles[index].route == selectedRoute)
                            ? widget.headerTextColorSelected
                            : widget.headerTextColor ?? Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
