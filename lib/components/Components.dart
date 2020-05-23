import 'package:Loan/constans.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {

  final String title;
  final body;

  MyAppBar({Key key, @required this.title, @required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Scaffold(
        appBar: AppBar(
          title:
              Text(title, style: TextStyle(color: Constans.StdBlack)),
          elevation: 0,
          shape: Border(bottom: BorderSide(color: Constans.UltraLightGrey)),
          iconTheme: IconThemeData(
            color: Constans.PrimaryColor
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: body
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
  final EdgeInsetsGeometry margin;

  MyButton({Key key, this.text, @required this.onPressed, this.widget, this.margin, this.textColor, this.isActive = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin != null ? margin : null,
      child: (RaisedButton(
        onPressed: () {onPressed();},
        child: widget == null ? Text(text, style: TextStyle(fontSize: 15)) : widget,
        color: isActive ? Constans.PrimaryColor : Constans.UltraLightGrey,
        textColor: textColor == null ? isActive ? Colors.white : Constans.Grey : textColor,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
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

  MySection({Key key, @required this.title, this.infoText, this.subtitle, this.body, this.divider=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: divider ?
           BorderSide(width: 1, color: Constans.UltraLightGrey)
           : BorderSide.none
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: subtitle == null ? EdgeInsets.only(bottom: 10) : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Constans.StdBlack)),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
          if (body != null) body,
          if (infoText != null)
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(infoText, style: TextStyle(fontSize: 15, color: Constans.Grey)),
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

  MyInput({Key key, @required this.placeholder, this.margin, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Constans.UltraLightGrey),
      child: (
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 13, vertical: 10
            ),
            hintText: placeholder,
            hintStyle: TextStyle(color: Constans.LightGrey),
          ),
        )
      ),
    );
  }
}

class MySelectButton extends StatelessWidget {
  
  final String text;
  final Function onPressed;

  MySelectButton({Key key, @required this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Constans.UltraLightGrey),
        child: FlatButton(
          child: Text(text, style: TextStyle(fontSize: 17),),
          onPressed: () => onPressed(),
        )
      )
    );
  }
}