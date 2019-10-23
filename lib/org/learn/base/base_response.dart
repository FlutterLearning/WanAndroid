class BaseRspData<T> {
  static const int SUCCESS = 1;

  int code;
  String msg;
  int total;
  dynamic data;
  int currentTime;

  BaseRspData({this.code, this.msg, this.total, this.data, this.currentTime});

  BaseRspData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    total = json['total'];
    data = json['data'];
    currentTime = json['currentTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['total'] = this.total;
    data['data'] = this.data;
    data['currentTime'] = this.currentTime;
    return data;
  }
}
