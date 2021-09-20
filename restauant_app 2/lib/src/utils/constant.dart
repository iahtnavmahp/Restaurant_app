class Constant {
  static String urlLink = "http://51a4-113-22-20-53.ngrok.io";

  static String KEY_USER = "USER";
  static String KEY_FULLNAME = "FULLNAME";
  static String KEY_EMAIL = "EMAIL";
  static String KEY_ROLES = "ROLES";
  static String KEY_ACCESSTOKEN = "ACCESSTOKEN";


  static String titleApp = "RESTAURANT";
  static String user = "Nhập tên tài khoản";
  static String password = "Nhập mật khẩu";
  static String sigIn = "ĐĂNG NHẬP";
  static String changePassword = "ĐỔI MẬT KHẨU";
  static String enterChangePasswordHT = "Nhập mật khẩu hiện tại";
  static String enterChangePasswordM = "Nhập mật khẩu mới";

  static String errorUsername = "Bạn chưa nhập tên đăng nhập";
  static String errorPassword = "Bạn chưa nhập mật khẩu";
  static String errorPasswordNew = "Bạn chưa nhập mật khẩu mới";
  static String errorPasswordNL = "Mật khẩu nhập lại phải khớp với mật khẩu mới.";
  static String titleHome = "Quản lý bàn";
  static String numberOfTablesAvailable = "Số bàn còn trống: ";
  static String search = "Tìm kiếm";
  static String confirm = "Xác nhận";
  static String changePasswordV1 = "Đổi mật khẩu?";
  static String changePasswordV2 = "Đổi mật khẩu";

  static String manager = "Restaurant manager";
  static String name = "Tên";
  static String phone = "Số điện thoại";
  static String address = "Địa chỉ";
  static String birthday = "Ngày sinh";
  static String roles = "Phân quyền tài khoản";
  static String username_v2 = "Username";
  static String password_v2 = "Passowrd";
  static String acti = "Hoạt động";
  static String edit = "Thay đổi";
  static String category = "Tên thể loại";
  static String nameFood = "Tên món ăn";
  static String price = "Giá bán";
  static String imageFood = "Ảnh món ăn";
  static String nameEmp = "Tên nhân viên";
  static String communications = "Thông tin liên lạc khác";
  static String updateEm = "Cập nhật nhân viên";
  static String deleteEm = "Xoá nhân viên";
  static String addEm = "Thêm nhân viên";

  static String customerName = "Tên khách hàng";
  static String customerPhone = "Số điện thoại của khách hàng";
  static String amountOfPeople = "Số người";
  static String note = "Ghi chú";
  static String config = "Xác nhận";

  static List<String> lisHome = [
    "Bàn số 1",
    "Bàn số 2",
    "Bàn số 3",
    "Bàn số 4",
    "Bàn số 5",
    "Bàn số 6",
    "Bàn số 7",
  ];

  static List listMenuOrderFood = [
    {"id": 1, "status": true, "name": "ĐỒ ĂN"},
    {"id": 2, "status": true, "name": "ĐỒ UỐNG"},
    {"id": 3, "status": true, "name": "TRÁNG MIỆNG"},
  ];

  static List listFood = [
    {"id": 1, "status": true, "name": "Lòng lợn tiết canh", "image": "assets/image/im_food.jpeg", "price": 900.000},
    {"id": 2, "status": true, "name": "Bún đậu mắm tôm", "image": "assets/image/im_food_1.jpg", "price": 900.000},
    {"id": 3, "status": true, "name": "Bún bò huế", "image": "assets/image/im_food_2.jpg", "price": 900.000},
    {"id": 4, "status": true, "name": "Lẩu thái", "image": "assets/image/im_food_3.jpg", "price": 900.000},
    {"id": 5, "status": true, "name": "món 5", "image": "assets/image/im_food.jpeg", "price": 900.000},
    {"id": 6, "status": true, "name": "Lẩu thập cẩm hồng công", "image": "assets/image/im_food_3.jpg", "price": 900.000},
    {"id": 7, "status": true, "name": "món 7", "image": "assets/image/im_food_1.jpg", "price": 900.000},
  ];
}
