import 'package:http/http.dart' as http;
class BaseURL{
  static final String baseURL = "https://eawapi-dev-as.azurewebsites.net/api/v1";
  static final int successCode = 200;
  static var client = http.Client();
}
class UrlUser{
  static final String getUser = "/TokenUsers" ;
}

class Pages{
  static final String getHomePage = "/home";
  static final String getLoginPage = "/login";
  static final String getSchedulePage = "/schedule";
  static final String getHistoryPage = "/history";
  static final String getInformationPage = "/information";
  static final String getLoadingToHomePage = "/loading";
  static final String getLoadingSignOutPage = "/logout";
}