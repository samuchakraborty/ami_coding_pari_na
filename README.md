# Project Name

## ami_coding_pari_na

### Table of Contents

You're sections headers will be used to reference location of destination.

  - [Description](#description)
  - [How To Use](#how-to-use)
  - [Demo](#demo)
  - [DataBase](#database)
  - [Khoj Function](#khoj-function)
  - [Dekhao Chobi](#dekhao-chobi)
  - [Project Images](#project-images)
  - [Uses Packages](#uses-packages)
  - [Author Info](#author-info)

## Description

The project is build for implementing the 'Khoj the search' & 'Dekhao chobi'. For that, user must be authentic. Performing those two functionality, if user  not register, he/she can not.
Authentication is simple; just type userName, mobile & password. It's store in sqflite database.

## How To Use

Clone this project and Run this command 'flutter run'.
Or use this apk [ami_coding_pari_na.zip]([ami_coding_pari_na.zip](https://github.com/samuchakraborty/ami_coding_pari_na/files/6726784/ami_coding_pari_na.zip)
)


## FlowChart

![project_flowchart](https://user-images.githubusercontent.com/61682653/123653485-ff777680-d84e-11eb-8ee1-860c1b02bc01.png)


## Demo



https://user-images.githubusercontent.com/61682653/123649299-7874cf00-d84b-11eb-8542-7204482317d1.mp4





## DataBase

- User Model
```
class User {
  int? id;
  String? mobile;
  String? userName;
  String? password;

  User({this.id, this.mobile, this.password, this.userName});

  Map<String, dynamic> toUser() {
    var map = <String, dynamic>{
      'id': id,
      'mobile': mobile,
      'username': userName,
      'password': password
    };

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    mobile = map['mobile'];
    userName = map['userName'];
    password = map['password'];
  }
}
```

- Store Data Model
```
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




```



 - Create DataBase 
```
 late Database _db;
  static const String ID = 'id';
  static const String USER_NAME = 'userName';
  static const String USER_PASSWORD = 'password';
  static const String USER_MOBILE = 'mobile';

  //for user LOGIN AND REGISTRATION
  static const String USER_TABLE = 'user';
  static const String USER_DB_NAME = 'user.db';

 //STORE DATA
  static const String USER_STORE_TABLE = 'storeData';
  static const String STORE_ID = 'id';
  static const String USER_STORE_TIMESTAMP = 'timestamp';
  static const String USER_STORE_VALUE = 'storeValue';
  static const String USER_SEARCH_BY_VALUE= 'searchByValue';
  static const String USER_SEARCH_RESULT= 'result';

Future<Database> get db async {
    // if (_db != null) {
    //   return _db;
    // }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, USER_DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $USER_TABLE ($ID INTEGER PRIMARY KEY autoincrement, $USER_NAME TEXT, $USER_MOBILE TEXT, $USER_PASSWORD TEXT)");

    await db.execute(
        "CREATE TABLE $USER_STORE_TABLE ($STORE_ID INTEGER, $USER_STORE_VALUE TEXT, $USER_SEARCH_BY_VALUE TEXT, $USER_STORE_TIMESTAMP TEXT, $USER_SEARCH_RESULT TEXT )");


  }
  
    Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

```
- Sign up User

```

  Future signUpUser(User user) async {
    var dbClient = await db;
    int id = await dbClient.insert(USER_TABLE, user.toUser());
    print(id);
    return id;
  }

```
- Login User

```
  Future<User?> loginUser({required mobile, required password}) async {
    var dbClient = await db;

    var result = await dbClient.rawQuery(
        "SELECT * FROM $USER_TABLE WHERE mobile = '$mobile' and password = '$password'");

    //var result = await dbClient.query(USER_TABLE, where: "id=?", whereArgs: [lastId]);
    print(result);
    return result.length != 0 ? User.fromMap(result.first) : null;

    //return user;
  }

```
- Store Khoj Function Data
```
  Future storeData(StoreData user) async {
    var dbClient = await db;
    int id = await dbClient.insert(USER_STORE_TABLE, user.toStore());
    print(id);
    return id;
  
  }
```
- Get All Store Khoj Function Data
```
  Future<List<StoreData>?> getAllStoreDataById({id}) async {
    var dbClient = await db;
    var result =
    await dbClient.query(USER_STORE_TABLE, where: "id=?", whereArgs: [id]);
    print(result);
    List<StoreData>? list =
    result.isNotEmpty ? result.map((c) => StoreData.fromMap(c)).toList() : null;

    return list;
  }


```




## Khoj Function

```

  kojFunction({inputValues, searchValue}) async {
    List<String> array = inputValues.split(',');
    int value = int.parse(searchValue);

    List<int> dataListAsInt = array.map((data) => int.parse(data)).toList();

    dataListAsInt.sort((b, a) => a.compareTo(b));
    print(dataListAsInt);

    var s = dataListAsInt.contains(value);
    if (s) {
      print('True');
      // print(dataListAsInt.join(','));

      await DBHelper().storeData(
        StoreData(
          id: int.parse(widget.userId),
          timestamp: DateTime.now().toString(),
          searchByValue: searchValue.toString(),
          storeValue: dataListAsInt.join(',').toString(),
          result: "True",
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("The search value is matched"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      print('False');
      await DBHelper().storeData(
        StoreData(
          id: int.parse(widget.userId),
          timestamp: DateTime.now().toString(),
          searchByValue: searchValue.toString(),
          storeValue: dataListAsInt.join(',').toString(),
          result: "False",
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("The search value is not matched"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
 ``` 
  
  ## Dekhao Chobi
  - Api call
  ```
   Future getChobi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {

      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }
  }
 
  ```
  - Image Show

```
FutureBuilder(
            future: NetWork().getChobi(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CupertinoActivityIndicator(
                    radius: 30,
                  ),
                );
              } else {
                return GridView.builder(
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            crossAxisCount: 4,
                            crossAxisSpacing: 2,
                            height: 200,
                            mainAxisSpacing: 2),
                    itemCount: 100,
                    itemBuilder: (ctx, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ConstrainedBox(
                          constraints:  BoxConstraints(minHeight: 200 ),

                          child: Container(
                            //height: 200,
                            // margin: EdgeInsets.only(left: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Text("Image ${index+1}"),
                                SizedBox(height: 10,),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 2, right: 2),
                                  //  padding: EdgeInsets.all(10),
                                    child: Image.network(
                                      snapshot.data[index]['url'],

                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),

                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            },
          )
```
  
  





### Project Images

![signUpPage](https://user-images.githubusercontent.com/61682653/123607154-6bda8180-d81f-11eb-9a22-008fb130e3b3.png)
![loginPage](https://user-images.githubusercontent.com/61682653/123607171-6da44500-d81f-11eb-967f-bbb5a7a5a5dd.png)
![userDrawer](https://user-images.githubusercontent.com/61682653/123607157-6bda8180-d81f-11eb-93eb-11955369f513.png)
![userProfile](https://user-images.githubusercontent.com/61682653/123607161-6c731800-d81f-11eb-83fd-595e082d67ec.png)

![search_false](https://user-images.githubusercontent.com/61682653/123607144-69782780-d81f-11eb-90ae-17a6e88141f4.png)
![search_table](https://user-images.githubusercontent.com/61682653/123607147-6a10be00-d81f-11eb-8200-9c78cd59ed8c.png)
![search_with_true](https://user-images.githubusercontent.com/61682653/123607152-6b41eb00-d81f-11eb-8ca6-a823edda4869.png)
![imageShowProtatit](https://user-images.githubusercontent.com/61682653/123607169-6d0bae80-d81f-11eb-8b32-7004ea7c654f.png)
![imageshowLAndScape](https://user-images.githubusercontent.com/61682653/123607166-6d0bae80-d81f-11eb-90ae-c67a423821c4.png)

## Uses Packages
 - Sqflite
 - http
 - path_provider
 - intl
 - shared_preferences
 - animated_text_kit

## Author Info

- Linkedin - [@samuchakraborty](https://www.linkedin.com/in/samuchakraborty/)




