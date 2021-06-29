import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

// sayfa arkaplanlarında kullanılan resim içeren container yapısı
class BgWidget extends StatefulWidget {
  final Widget child;

  const BgWidget({Key key, this.child}) : super(key: key);
  @override
  _BgWidgetState createState() => _BgWidgetState();
}

class _BgWidgetState extends State<BgWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Svg("assets/images/bg.svg"),
          fit: BoxFit.cover,
          // resim erkanı kaplayacak
        ),
      ),
    );
  }
}
