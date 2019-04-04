import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsWeb extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var goodsDetail=Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    
   
      return  Provide<DetailsInfoProvide>(
        
        builder: (context,child,val){
           var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
           if(isLeft){
             return  Container(
                  child: Html(
                    data:goodsDetail
                  ),
              );
           }else{
            return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child:Text('暂时没有数据')
            );
           }
        },
      );
      
  }
}