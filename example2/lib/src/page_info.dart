import 'page_base.dart';

/// Page information object
class PageInfo {
  ///
  PageInfo(this.id, this.page);

  ///
  final String id;

  /// Page object
  final PageBase page;

  ///
  String get title => page.title;

  /// page root path
  String getPath() {
    return '/subpage$id';
  }
}
