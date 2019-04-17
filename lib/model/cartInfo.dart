class CartInfoMode {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;
  bool isCheck;

  CartInfoMode(
      {this.goodsId, this.goodsName, this.count, this.price, this.images,this.isCheck});

  CartInfoMode.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    data['isCheck']= this.isCheck;
    return data;
  }
}