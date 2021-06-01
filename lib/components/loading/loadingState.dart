import 'package:flutter/material.dart';
import 'package:troveapp/components/theme/color.dart';

class LoadingState extends StatelessWidget {
  final Widget child;
  final bool isAsyncCall;
  final valueColor = new AlwaysStoppedAnimation<Color>(Colors.blue);

  LoadingState({
    Key key,
    @required this.isAsyncCall,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if (isAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.5,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
          new Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white30),
            backgroundColor: altThemeColor,
          ))
        ],
      );
      widgetList.add(modal);
    }
    return Stack(children: widgetList);
  }
}
