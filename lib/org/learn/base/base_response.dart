class BaseRspData<T> {
  static const int SUCCESS = 0;

  int errorCode;
  String errorMsg;
  dynamic data;

  BaseRspData({this.errorCode, this.errorMsg, this.data});

  BaseRspData.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    data['data'] = this.data;
    return data;
  }
}
