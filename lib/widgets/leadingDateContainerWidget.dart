import 'package:envoy/settings/consts.dart';
import 'package:flutter/material.dart';

class LeadingDateContainerWidget extends StatelessWidget {
  final String content;
  final String leading;
  final Color containerColor;
  const LeadingDateContainerWidget({Key key, this.content, this.leading, this.containerColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width : deviceWidth(context),
      height: deviceHeight(context) * 0.05,
      color : containerColor,
      child : Center(child: Align(alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" $leading",style: cardTextStyle),
              Padding(padding: const EdgeInsets.only(right: minSpace),
                child: Text(content,style: contentTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//orderDetailData.siparisDetay.bosaltmaBelgeleri.last.tarih,style: contentTextStyle