import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Widget body;
  final bool divider;
  final List<Widget> actions;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  const MyAppBar(
      {Key key,
      @required this.title,
      @required this.body,
      this.actions,
      this.divider=true,
      this.floatingActionButtonLocation,
      this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Constans.StdBlack)),
        elevation: 0,
        shape: divider == true ? const Border(
            bottom: const BorderSide(color: Constans.UltraLightGrey)
          ) : null,
        actions: actions,
        iconTheme: const IconThemeData(color: Constans.PrimaryColor),
        // centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    ));
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final Widget widget;
  final Function onPressed;
  final bool isActive;
  final Color textColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final double fontSize;

  const MyButton(
      {Key key,
      this.text,
      @required this.onPressed,
      this.fontSize,
      this.backgroundColor,
      this.widget,
      this.margin,
      this.textColor,
      this.isActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin != null ? margin : null,
      child: (RaisedButton(
        highlightColor: Colors.transparent,
        highlightElevation: 0,
        onPressed: onPressed,
        child: widget == null
            ? Text(text,
                style: TextStyle(fontSize: fontSize == null ? 15 : fontSize))
            : widget,
        color: backgroundColor == null
            ? isActive ? Constans.PrimaryColor : Constans.MegaUltraLightGrey
            : backgroundColor,
        textColor: textColor == null
            ? isActive ? Colors.white : Constans.Grey
            : textColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      )),
    );
  }
}

class MySection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget body;
  final bool divider;
  final String infoText;

  const MySection(
      {Key key,
      @required this.title,
      this.infoText,
      this.subtitle,
      this.body,
      this.divider = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom: divider
                  ? const BorderSide(width: 1, color: Constans.UltraLightGrey)
                  : BorderSide.none)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: subtitle == null ? const EdgeInsets.only(bottom: 10) : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Constans.StdBlack)),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      subtitle,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
          if (body != null) Container(child: body),
          if (infoText != null)
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(infoText,
                  style: const TextStyle(fontSize: 13, color: Constans.Grey)),
            )
        ],
      ),
    ));
  }
}

class MyInput extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final int maxLines;
  final int maxLenght;
  final EdgeInsetsGeometry margin;
  final Function onChanged;
  final Function onTap;
  final TextInputType keyboardType;
  final Widget icon;
  final Widget suffixIcon;
  final FocusNode focusNode;

  const MyInput(
      {Key key,
      @required this.placeholder,
      this.focusNode,
      this.maxLenght,
      this.controller,
      this.suffixIcon,
      this.icon,
      this.keyboardType,
      this.margin,
      this.onTap,
      this.onChanged,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: maxLines == 1 || maxLines == null ? 50 : null,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Constans.MegaUltraLightGrey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if(icon != null)
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: icon,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              maxLength: maxLenght,
              maxLines: maxLines,
              keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                counterText: '',
                hintText: placeholder,
                hintStyle: const TextStyle(color: Constans.LightGrey),
                // contentPadding:
                //     const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              ),
              onTap: onTap,
              onChanged: (value) {
                onChanged(value);
              },
            ),
          ),
          if(suffixIcon != null)
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: suffixIcon,
          )
        ],
      ),
    );
  }
}
