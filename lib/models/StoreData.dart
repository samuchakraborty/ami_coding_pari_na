class StoreData {
  int? id;
  String? storeValue;
  String? searchByValue;
  String? timestamp;

  StoreData({this.id, this.storeValue, this.searchByValue, this.timestamp});

  Map<String, dynamic> toStore() {
    var map = <String, dynamic>{
      'id': id,
      'timestamp': timestamp,
      'storeValue': storeValue,
      'searchByValue': searchByValue
    };

    return map;
  }

  StoreData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    timestamp = map['timestamp'];
    storeValue = map['storeValue'];
    searchByValue = map['searchByValue'];
  }
}
