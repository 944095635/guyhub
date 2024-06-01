/// 搜索项
class Search {
  /// 名称
  late String name;

  /// 文件大小
  late String size;

  /// 文件数量
  late String count;

  /// 日期
  late String date;

  /// 文件列表
  late List<SearchFile> files;

  /// 链接
  String? href;

  /// 磁链地址
  String? magnet;
  Search({this.size = "", this.count = ""});
}

class SearchFile {
  /// 名称
  late String name;

  /// 文件大小
  String? size;
}
