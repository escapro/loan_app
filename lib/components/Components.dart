import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {

  final String title;
  final Widget body;
  final List<Widget> actions;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  const MyAppBar({Key key, @required this.title, @required this.body, this.actions, this.floatingActionButtonLocation, this.floatingActionButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Scaffold(
        appBar: AppBar(
          title:
              Text(title, style: const TextStyle(color: Constans.StdBlack)),
          elevation: 0,
          shape: const Border(bottom: const BorderSide(color: Constans.UltraLightGrey)),
          actions: actions,
          iconTheme: const IconThemeData(
            color: Constans.PrimaryColor
          ),
          // centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      )
    );
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

  const MyButton({Key key, this.text, @required this.onPressed, this.fontSize, this.backgroundColor, this.widget, this.margin, this.textColor, this.isActive = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: margin != null ? margin : null,
      child: (RaisedButton(
        onPressed: onPressed,
        child: widget == null ? Text(text, style: TextStyle(fontSize: fontSize == null ? 15 : fontSize)) : widget,
        color: backgroundColor == null ? isActive ? Constans.PrimaryColor : Constans.UltraLightGrey : backgroundColor,
        textColor: textColor == null ? isActive ? Colors.white : Constans.Grey : textColor,
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

  const MySection({Key key, @required this.title, this.infoText, this.subtitle, this.body, this.divider=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: divider ?
           const BorderSide(width: 1, color: Constans.UltraLightGrey)
           : BorderSide.none
        )
      ),
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
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Constans.StdBlack)),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      subtitle,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
          if (body != null) Container(child: body),
          if (infoText != null)
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(infoText, style: const TextStyle(fontSize: 15, color: Constans.Grey)),
          )
        ],
      ),
    ));
  }
}

class MyInput extends StatelessWidget {
  
  final String placeholder;
  final int maxLines;
  final EdgeInsetsGeometry margin;
  final Function onChanged;
  final TextInputType keyboardType;

  const MyInput({Key key, @required this.placeholder, this.keyboardType, this.margin, this.onChanged, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: maxLines == 1 || maxLines == null ? 45 : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),  
        color: Constans.UltraLightGrey),
      child: (
        TextField(
          maxLines: maxLines,
          keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: placeholder,
            hintStyle: const TextStyle(color: Constans.LightGrey),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 10
            ),
          ),
          onChanged: (value) {
            onChanged(value);
          },
        )
      ),
    );
  }
}