import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//商品详情页的首屏区域，包括图片、商品名称，商品价格，商品编号的UI展示
class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(

      builder:(context,child,val){
        var goodsInfo=Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;

        if(goodsInfo != null){

           return Container(
                 color: Colors.white,
                padding: EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                      _goodsImage( goodsInfo.image1),
                      _goodsName( goodsInfo.goodsName ),  
                      _goodsNum(goodsInfo.goodsSerialNumber),
                      _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice),
                    
                  ],
                ),
              );

        }else{
          return Text('正在加载中......');
        }
      }
    );
  }

  //商品图片
  Widget _goodsImage(url){
    return  Image.network(
        url,
        width:ScreenUtil().setWidth(740) 
    );

  }

  //商品名称
  Widget _goodsName(name){

      return Container(
        
        width: ScreenUtil().setWidth(730),
        padding: EdgeInsets.only(left:15.0),
        child: Text(
          name,
          maxLines: 1,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
          ),
        ),
      );
  }

  //商品编号

  Widget _goodsNum(num){
    return  Container(
     
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Text(
        '编号:${num}',
        style: TextStyle(
          color: Colors.black26
        ),
      ),
      
    );
  }

  //商品价格方法

  Widget _goodsPrice(presentPrice,oriPrice){

    return  Container(
      
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥${presentPrice}',
            style: TextStyle(
              color:Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),

            ),

          ),
          Text(
            '市场价:￥${oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough
            ),
                
            
            )
        ],
      ),
    );

  }
  
  

}