import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBarWidget extends StatelessWidget {
  final String? title;
  final bool visibleTitle;
  final Color? colorTitle;
  final Color backgroundColor;
  final Function()? onBackPressed;
  final Function()? actionsPressed;
  final Icon? iconLeading;
  final bool showLeading;
  final Icon? iconAction;
  final bool showAction;
  final double elevation;


  AppBarWidget({
    Key? key,
    this.title,
    this.visibleTitle = true,
    this.colorTitle,
    this.backgroundColor = Colors.white,
    this.showLeading = true,
    this.showAction = false,
    this.iconAction,
    this.iconLeading,
    this.onBackPressed,
    this.actionsPressed,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: elevation,
      title: visibleTitle
          ? Text(
              title!,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: colorTitle ?? Theme.of(context).primaryColor,
                  ),
            )
          : SizedBox.shrink(),
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      leading: showLeading
          ? IconButton(
              icon: iconLeading ??
                  Icon(
                    Icons.arrow_back_ios,
                  ),
              onPressed: onBackPressed ??
                  () {
                    Modular.to.pop();
                  },
            )
          : SizedBox.shrink(),
      actions: <Widget>[
        if (showAction)
          IconButton(
            icon: iconAction ??
                Icon(
                  Icons.check,
                ),
            onPressed: actionsPressed ??
                () {},
          ),
      ],
    );
  }
}
