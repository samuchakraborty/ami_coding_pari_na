class StoreData {
  int? id;
  String? storeValue;
  String? searchByValue;
  String? timestamp;
  String? result;

  StoreData(
      {this.id,
      this.storeValue,
      this.searchByValue,
      this.timestamp,
      this.result});

  Map<String, dynamic> toStore() {
    var map = <String, dynamic>{
      'id': id,
      'timestamp': timestamp,
      'storeValue': storeValue,
      'searchByValue': searchByValue,
      'result': result
    };

    return map;
  }

  StoreData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    timestamp = map['timestamp'];
    storeValue = map['storeValue'];
    searchByValue = map['searchByValue'];
    result = map['result'];
  }
}
