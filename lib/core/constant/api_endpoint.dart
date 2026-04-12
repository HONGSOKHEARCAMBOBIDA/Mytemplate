class ApiEndpoint {
  static const String Login = "login";
  static String ViewBranch = "view.branch";
  static String AddBranch = "add.branch";
  static UpdateBranch(int id) => "update.branch/$id";
  static ChangeStatusBranch(int id) => "change.status.branch/$id";
  static const ViewAllShift = "view.all.shift";
  static ViewShfitByBranchID(int id) => "view.shift.by.branch.id/$id";
  static const AddShift = "add.shift";
  static UpdateShift(int id) => "update.shift/$id";
  static ChangeStatusShift(int id) => "change.status.shift/$id";
  static String ViewAllShiftSession = "view.all.shift.session";
  static ViewShiftSessionByShiftID(int id) => "view.shift.session.by.shift.id/$id";
  static String AddShiftSession = "add.shift.session";
  static UpdateShiftSession(int id) => "update.shift.session/$id";
  static ChangeStatusShiftSession(int id) => "change.status.shift.session/$id";
}
