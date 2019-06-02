

import 'package:flutter/material.dart';

/// 对话框的显示参数
class ShowParam {

  bool show = true; // 默认显示对话框
  bool showBackground = true; // 显示背景
  bool barrierDismissible = false; // 空白区域点击后是否消失
  bool dispose = false;
  String text;
  BuildContext context;

  ShowParam({this.show = true, this.showBackground = true, this.barrierDismissible = true, this.text,
      this.context}); //ShowParam({this.show = true, this.barrierDismissible, this.context, this.text});


  void pop() {
    if (context != null && !dispose) {
      Navigator.of(context).pop();
    }
  }
}