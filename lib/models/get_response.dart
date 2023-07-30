class GetResponse {
  final String _module;
  final String? _message;
  final dynamic _data;
  final int? _dataCount;

  GetResponse(Map<String, dynamic> object)
      : _module = object['module'],
        _message = object['message'],
        _data = object['data'],
        _dataCount = object['data_count'];
  String get module => _module;
  String? get message => _message ?? '';
  dynamic get getData => _data;
  int get dataCount => _dataCount ?? 0;
}
