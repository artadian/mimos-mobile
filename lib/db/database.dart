import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "mimos.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  // void initDB(Database database, int version) async {
  //   await database.execute("CREATE TABLE $todoTABLE ("
  //       "id INTEGER PRIMARY KEY, "
  //       "description TEXT, "
  //       /*SQLITE doesn't have boolean type
  //       so we store isDone as integer where 0 is false
  //       and 1 is true*/
  //       "is_done INTEGER "
  //       ")");
  // }
  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE customer ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "customerno TEXT, "
        "tanggalkunjungan TEXT, "
        "name TEXT, "
        "address TEXT, "
        "city TEXT, "
        "owner TEXT, "
        "phone TEXT, "
        "customergroupid TEXT, "
        "customergroupname TEXT, "
        "priceid TEXT, "
        "salesdistrictid TEXT, "
        "salesdistrictname TEXT, "
        "usersfaid TEXT, "
        "userid TEXT, "
        "visitday TEXT, "
        "visitweek TEXT, "
        "userroleid TEXT, "
        "salesgroupid TEXT, "
        "salesgroupname TEXT, "
        "salesofficeid TEXT, "
        "salesofficename TEXT, "
        "regionid TEXT, "
        "year TEXT, "
        "cycle TEXT, "
        "week TEXT, "
        "wspclass TEXT, "
        "nourut INTEGER "
        ")");

    /// table material
    await database.execute("CREATE TABLE materialtf ("
        "matmfid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "materialid TEXT, "
        "materialname TEXT, "
        "materialgroupid TEXT, "
        "bal INTEGER, "
        "slof INTEGER, "
        "pac INTEGER, "
        "materialgroupdescription TEXT "
        ")");

    /// table price
    await database.execute("CREATE TABLE price ("
        "pricemfid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "materialid TEXT, "
        "materialname TEXT, "
        "priceid TEXT, "
        "harga INTEGER, "
        "since INTEGER, "
        "tglmulaiberlaku TEXT"
        ")");

    /// table lookup
    await database.execute("CREATE TABLE lookup ("
        "lookupid TEXT PRIMARY KEY,"
        "lookupkey TEXT, "
        "lookupvalue TEXT, "
        "lookupdesc TEXT "
        ")");

    /// table introdeal
    await database.execute("CREATE TABLE introdeal ("
        "intromfid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "introdealid TEXT, "
        "materialid TEXT, "
        "materialname TEXT, "
        "qtyorder INTEGER, "
        "qtybonus INTEGER, "
        "since INTEGER, "
        "tglmulaiberlaku TEXT,"
        "expired INTEGER, "
        "tglakhirberlaku TEXT"
        ")");

    /// table customer introdeal dari back end
    await database.execute("CREATE TABLE customer_introdeal ("
        "custintroid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "introdealid TEXT, "
        "materialid TEXT, "
        "customerno TEXT "
        ")");
    // table visitTF
    await database.execute("CREATE TABLE visittf ("
        "visittrxid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "customerno TEXT, "
        "nonota TEXT, "
        "tglkunjungan TEXT, "
        "userid TEXT, "
        "notvisitreason TEXT, "
        "notbuyreason TEXT, "
        "getidsellin TEXT, "
        "getidvisit TEXT, "
        "getidstock TEXT, "
        "getidposm TEXT, "
        "getidvisibility TEXT, "
        "iseditposm TEXT, "
        "iseditsellin TEXT, "
        "iseditstock TEXT, "
        "iseditvisibility TEXT, "
        "amount INTEGER "
        ")");
    // StockTF
    await database.execute("CREATE TABLE stocktf ("
        "stocktrxid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "customerno TEXT, "
        "userid TEXT, "
        "tglkunjungan TEXT, "
        "materialid TEXT, "
        "bal INTEGER, "
        "slof INTEGER, "
        "qtystock INTEGER, "
        "getidstockdetail TEXT, "
        "ismaterialdefault TEXT, "
        "iscek TEXT, "
        "pac INTEGER"
        ")");
    // Visibility
    await database.execute("CREATE TABLE visibility ("
        "visibilitytrxid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "customerno TEXT, "
        "userid TEXT, "
        "tglkunjungan TEXT, "
        "materialid TEXT, "
        "getidvisibilitydetail TEXT, "
        "ismaterialdefault TEXT, "
        "iscek TEXT, "
        "pac INTEGER"
        ")");
    // Visibilitywsp
    await database.execute("CREATE TABLE visibility_wsp ("
        "visibilitywsptrxid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "materialgroupid TEXT, "
        "materialid TEXT, "
        "wspclass TEXT, "
        "customerno TEXT, "
        "tglkunjungan TEXT, "
        "pac INTEGER"
        ")");
    // penjualan
    await database.execute("CREATE TABLE penjualan ("
        "penjualantrxid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "customerno TEXT, "
        "userid TEXT, "
        "tglkunjungan TEXT, "
        "materialid TEXT, "
        "bal INTEGER, "
        "slof INTEGER, "
        "pac INTEGER, "
        "introdeal INTEGER, "
        "introdealid TEXT, "
        "qtypenjualan INTEGER, "
        "getidsellindetail TEXT, "
        "harga INTEGER"
        ")");
    // POSM
    await database.execute("CREATE TABLE posmtf ("
        "posmtrxid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "customerno TEXT, "
        "userid TEXT, "
        "tglkunjungan TEXT, "
        "materialid TEXT, "
        "type TEXT, "
        "qty INTEGER, "
        "status TEXT, "
        "note TEXT, "
        "getidposmdetail TEXT, "
        "condition TEXT"
        ")");

    /// table material Frontliner
    await database.execute("CREATE TABLE materialfl ("
        "matid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "materialid TEXT, "
        "materialname TEXT, "
        "materialgroupid TEXT, "
        "materialgroupdescription TEXT, "
        "priceid TEXT, "
        "price INTEGER "
        ")");

    /// table brand competitor Frontliner
    await database.execute("CREATE TABLE competitor ("
        "sobid TEXT, "
        "salesofficeid TEXT, "
        "materialgroupid TEXT, "
        "competitorbrand TEXT "
        ")");
  }
}
