class BaseURL {
  static final String baseURL =
      "https://eawwebapi-dev-as.azurewebsites.net/api/v1/";
  static final int successCode = 200;
}

class UrlApi {
  static final String checkLogin = "login";
  static final String getHome = "home";
  static final String getInformation = "information";
  static final String getSchedule = "schedule";
}

class ShareRef {
  static final String tokenKey = "tokenKey";
  static final String userId = "userId";
  static final String userName = "userName";
  static final String image = "image";
}

class Pages {
  static final String getHomePage = "/home";
  static final String getLoginPage = "/login";
  static final String getSchedulePage = "/schedule";
  static final String getHistoryPage = "/history";
  static final String getInformationPage = "/information";
  static final String getLoadingToHomePage = "/loading";
  static final String getLoadingSignOutPage = "/logout";
}
