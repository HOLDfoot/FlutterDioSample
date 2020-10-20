import 'package:flutter/material.dart';

/// 对话框的显示参数
class ShowParam {
  bool show = true; // 默认显示对话框
  bool showBackground = true; // 显示背景
  bool barrierDismissible = false; // 空白区域点击后是否消失
  bool dispose = false;

  /// 设置已经/需要 pop的标志位
  String text;
  BuildContext context;

  ShowParam(
      {this.show = true,
        this.showBackground = true,
        this.barrierDismissible = true,
        this.text,
        this.context})
      : dispose = false {
    show = show == null ? false : show;
  }

  void pop() {
    /// 如果当前对话框本身就没有显示, 压根就不用pop
    if (!show) return;
    if (context != null &&
        Navigator.of(context) != null &&
        Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      show = false; // 表示已经彻底结束显示该对话框
    }
    dispose = true; // 如果网络返回太快, 对话框还没有显示, 则设置已经dispose标志位
  }

  void judgeNeedPop(BuildContext context) {
    this.context = context;
    if (dispose) {
      /// 当已经置成true的时候再调用build延迟pop, 防止异常(setState() or markNeedsBuild() called during build.)
      Future.delayed(Duration(milliseconds: 100)).then((onValue) {
        pop();
      });
    }
  }
}
