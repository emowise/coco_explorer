import 'package:flutter/widgets.dart';

class ImagePagination extends ChangeNotifier{

  final int pageSize;

  ImagePagination({ this.pageSize = 5});

  List<int> _imageIds=[];
  int _pageCount = 0;

  List<int> get imageIds=>_imageIds;
  int get pageCount=>_pageCount;

  void clearPageCount(){
    _pageCount=0;
    notifyListeners();
  }

  set imageIds(List<int> newImageIds){
    _imageIds=newImageIds;
    clearPageCount();
    notifyListeners();
  }

  List<int> queryImageIds() {
    List<int> paginationIds = _imageIds.sublist(
        _pageCount * pageSize,
        (_pageCount * pageSize) + pageSize <= _imageIds.length
            ? (_pageCount * pageSize)+pageSize
            : _imageIds.length);

    _pageCount++;
    notifyListeners();
    return paginationIds;
  }
}
