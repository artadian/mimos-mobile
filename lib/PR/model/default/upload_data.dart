
class UploadData<T> {
  bool status;
  String message;
  String type;
  T data;

  UploadData({this.status, this.message, this.type, this.data});
}