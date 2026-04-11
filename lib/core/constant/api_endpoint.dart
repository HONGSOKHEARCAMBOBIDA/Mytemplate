class ApiEndpoint {
  static const String Login = "login";
  static String ViewBranch = "view.branch";
  static String AddBranch = "add.branch";
  static  UpdateBranch(int id) => "update.branch/$id";
  static  ChangeStatusBranch(int id) => "change.status.branch/$id";
}
