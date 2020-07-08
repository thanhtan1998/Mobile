import 'package:shared_preferences/shared_preferences.dart';

class SharedReference {

  removeAllObject()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  addStringToSF(String key, String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, stringValue);
  }

  addIntToSF(String key, int intValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, intValue);
  }

  addDoubleToSF(String key, double doubleValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, doubleValue);
  }

  addBoolToSF(String key, bool boolValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, boolValue);
  }

  getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(key);
    return Future.value(stringValue);
  }

  getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool(key);
    return boolValue;
  }

   getIntValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt(key);
    return intValue;
  }

  getDoubleValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    double doubleValue = prefs.getDouble(key);
    return doubleValue;
  }
}final sharedRef = SharedReference();
