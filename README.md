# OpenHeart

**🟦 Quy trình lấy code windmill:**
- Clone/pull workspace về
- Chạy lệnh sau để xem workspace trên self-host hiện tại đang chọn là gì:  
  ```wmill workspace```
- Nếu workspace trên self-host không tồn tại hoặc muốn thêm workspace mới, gõ lệnh sau:  
  ```wmill workspace add <tên workspace> <địa chỉ url workspace>```
- Nếu muốn đổi sang một workspace trên self-host đã tồn tại:  
  ```wmill workspace switch <tên workspace>```  
- Đẩy những thay đổi từ thư mục workspace trên máy lên workspace đã chọn:  
  ```wmill sync push```
- Kéo những thay đổi từ workspace đã chọn vào thư mục trên máy:  
  ```wmill sync pull```
<mark>

Lưu ý:  
- Bạn chỉ có thể chọn một workspace đã được tạo trên self-host  
- Workspace này sẽ nơi pull và push dữ liệu, cần chọn workspace phù hợp và hoạt động xuyên suốt trên đây  
- Dữ liệu muốn được lưu trên workspace phải được lưu trong thư mục (Folder) và được Deloy (xuất bản)
- Các giá trị biến (Variables) và tài nguyên (Resources) không được lưu cùng workspace, bạn phải khởi tạo lại nếu là lần đầu sử dụng workspace này  
- Những hàm Python cần phải chạy thư viện để hoạt động, yêu cầu chạy hàm "Hàm cài đặt thư viện" để cài đặt những thư viện cần thiết trước khi chạy app 

</mark>
