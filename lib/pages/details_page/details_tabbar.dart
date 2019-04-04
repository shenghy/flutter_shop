import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';

class DetailsTabBar extends StatelessWidget {
  
    Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft= Provide.value<DetailsInfoProvide>(context).isLeft;
        var isRight =Provide.value<DetailsInfoProvide>(context).isRight;
       
        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _myTabBarLeft(context,isLeft),
                  _myTabBarRight(context,isRight)
                ],
              ),
            ],


          ),
          
        ) ;
      },
      
    ); 
  }

  Widget _myTabBarLeft(BuildContext context,bool isLeft){
    return InkWell(
      onTap: (){
      
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('left');
      },
      child: Container(
       
        padding:EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft?Colors.pink:Colors.black12 
            )
          )
        ),
        child: Text(
          '详细',
          style: TextStyle(
            color:isLeft?Colors.pink:Colors.black 
          ),
        ),
      ),
    );
  }
  Widget _myTabBarRight(BuildContext context,bool isRight){
    return InkWell(
      onTap: (){
      
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('right');
      },
      child: Container(
         
        padding:EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight?Colors.pink:Colors.black12 
            )
          )
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color:isRight?Colors.pink:Colors.black 
          ),
        ),
      ),
    );
  }

}