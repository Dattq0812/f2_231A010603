# Báo Cáo Dự Án Thực Hành Lab F2 - Flutter Layout

Dự án này là bài thực hành xây dựng giao diện người dùng (UI) bằng Flutter (Material 3), dựa trên thiết kế của màn hình "Cổng thực hành LTDD" (Lab A3 - Android XML).

## 👤 Thông tin sinh viên
*   **Họ và tên:** Trần Quốc Đạt
*   **MSSV:** 231A010603
*   **Lớp:** 252INT440707

---

## 🚀 Các chức năng cơ bản (Theo chuẩn Lab F2)

1.  **Bố cục giao diện bằng các Widget cốt lõi:**
    *   Sử dụng `Container`, `Row`, `Column` để sắp xếp các thành phần văn bản, ô nhập liệu và nút bấm.
    *   Áp dụng `Padding`, `SizedBox` để tạo khoảng cách hợp lý.
    *   Sử dụng `Stack` và `Positioned` để thiết kế phần Header Banner: chồng ảnh đại diện (Avatar) lên đường viền dưới của ảnh bìa Gradient.
2.  **Khắc phục lỗi RenderFlex Overflow:**
    *   Màn hình được bọc trong `SingleChildScrollView` kết hợp `SafeArea`. Điều này đảm bảo khi người dùng nhấn vào `TextField`, bàn phím ảo hiện lên sẽ không đẩy nội dung gây ra lỗi tràn màn hình (RenderFlex overflowed).
3.  **Giao diện thích ứng (Responsive) với LayoutBuilder:**
    *   **Màn hình dọc (Điện thoại):** Các thành phần (Form đăng nhập, Thẻ hồ sơ) được xếp dọc 1 cột.
    *   **Màn hình ngang (Tablet/Web):** Sử dụng `LayoutBuilder` để đo chiều rộng. Nếu chiều rộng `>= 700px`, giao diện tự động chia làm 2 cột bằng `Row` và `Expanded` (Form đăng nhập chiếm flex 3, Thẻ hồ sơ chiếm flex 2).
4.  **Tương tác cơ bản:**
    *   Ẩn/hiện mật khẩu trong `TextField` sử dụng trạng thái `setState`.
    *   Nút Đăng nhập sẽ kích hoạt một `SnackBar` thông báo thành công.

---

## 🌟 Các chức năng nâng cao (Bài tập tự chọn)

### 1. NC1: Chế độ Tối (Dark Mode & Theme Toggling)
*   **Mô tả:** Thêm chức năng cho phép người dùng chuyển đổi qua lại giữa giao diện Sáng (Light Mode) và Tối (Dark Mode).
*   **Luồng hoạt động chi tiết:**
    *   Biến lớp `MyApp` (ở file `main.dart`) thành `StatefulWidget` để có thể nắm giữ biến trạng thái `_themeMode` (kiểu `ThemeMode`).
    *   Định nghĩa hàm `toggleTheme()` dùng `setState` để đảo ngược giá trị giữa `ThemeMode.light` và `ThemeMode.dark`.
    *   Khởi tạo cả hai cấu hình `theme` (Sáng) và `darkTheme` (Tối) trong `MaterialApp` sử dụng `ColorScheme.fromSeed` với tuỳ chọn `brightness`.
    *   Truyền hàm `toggleTheme` dưới dạng một hàm callback (`VoidCallback`) xuống widget con là `LoginPage`, rồi từ `LoginPage` tiếp tục truyền xuống `HeaderBanner`.
    *   Tại `HeaderBanner`, một nút `IconButton` hình mặt trăng/mặt trời sẽ được đặt ở góc trên. Khi bấm vào, nó gọi hàm callback chạy ngược lên `MyApp`, khiến ứng dụng cập nhật toàn bộ giao diện mà không cần reload.

### 2. NC2: Tối ưu hóa kiến trúc (Tách File/Widget)
*   **Mô tả:** Tách các khối UI lớn ra khỏi `main.dart` để dễ quản lý, tái sử dụng và tuân thủ nguyên tắc Clean Code.
*   **Cấu trúc thư mục mới:**
    ```text
    lib/
    ├── main.dart                 # Điểm bắt đầu, chứa MaterialApp, điều hướng và bố cục LayoutBuilder
    └── widgets/
        ├── header_banner.dart    # Chứa widget HeaderBanner (Ảnh bìa, Title, Nút DarkMode, Avatar)
        └── profile_card.dart     # Chứa widget ProfileCard (Thẻ thông tin sinh viên) và StatBox
    ```
*   **Luồng hoạt động chi tiết:**
    *   Các Widget tĩnh hoặc có tính độc lập cao được chuyển vào thư mục `lib/widgets/`.
    *   Tại file `profile_card.dart`, lớp `_StatBox` (vốn là lớp riêng tư có dấu gạch dưới) đã được đổi tên thành `StatBox` (lớp công khai) để dễ dàng gọi trong cùng file hoặc chia sẻ sau này.
    *   File `main.dart` giờ đây chỉ làm nhiệm vụ import (`import 'widgets/header_banner.dart';`), quản lý trạng thái tổng và rẽ nhánh giao diện (1 cột hay 2 cột), giúp giảm hàng trăm dòng code so với việc gom tất cả vào một file.

---

## 🛠 Hướng dẫn chạy dự án

1. Clone thư mục dự án hoặc giải nén tệp `F2_231A010603.zip`.
2. Mở terminal tại thư mục gốc của dự án.
3. Chạy lệnh để lấy các gói phụ thuộc:
   ```bash
   flutter pub get
   ```
4. Chạy ứng dụng trên máy ảo (Emulator), thiết bị thật hoặc Chrome (để test Layout 2 cột):
   ```bash
   flutter run
   # hoặc test trên trình duyệt:
   flutter run -d chrome
   ```