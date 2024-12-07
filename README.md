[![Github license](https://img.shields.io/github/license/CTUbase/OpenHeart.svg 'Github license')](https://github.com/CTUbase/OpenHeart/blob/master/LICENSE)
[![Open issues](https://img.shields.io/github/issues/CTUbase/OpenHeart.svg 'Open issues')](https://github.com/CTUbase/OpenHeart/issues)
[![Open Pull Requests](https://img.shields.io/github/issues-pr/CTUbase/OpenHeart.svg 'Open Pull Requests')](https://github.com/CTUbase/OpenHeart/pulls)
[![Commit activity](https://img.shields.io/github/commit-activity/m/CTUbase/OpenHeart.svg 'Commit activity')](https://github.com/CTUbase/OpenHeart/graphs/commit-activity)
[![GitHub contributors](https://img.shields.io/github/contributors/CTUbase/OpenHeart.svg 'Github contributors')](https://github.com/CTUbase/OpenHeart/graphs/contributors)
![](./docs/images/new_banner.png)

![](./docs/images/vbqppl.png)

![](./docs/images/qna.png)

# OpenHeart

<a href="https://github.com/CTUbase/OpenHeart/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%F0%9F%90%9B+Bug+Report%3A+">Bug Report ⚠️
</a>
<a href="https://github.com/CTUbase/OpenHeart/issues/new?assignees=&labels=&projects=&template=feature_request.md&title=RequestFeature:">Request Feature 👩‍💻</a>

Ứng dụng hỗ trợ tổ chức phi lợi nhuận trong việc quản lý tình nguyện viên và tổ chức sự kiện một cách dễ dàng. Đây là nền tảng kết nối những người muốn tham gia tình nguyện với các cơ hội phù hợp, nhằm tạo ra tác động tích cực trong cộng đồng.

Mục tiêu của hệ thống là:
1. **Tăng cường hoạt động tình nguyện**: Giúp mọi người, đặc biệt là thế hệ trẻ (Gen Z), dễ dàng tìm kiếm và tham gia các hoạt động tình nguyện phù hợp với sở thích và thời gian của họ.

2. **Hỗ trợ tổ chức phi lợi nhuận**: Cung cấp các công cụ giúp các tổ chức dễ dàng quản lý sự kiện, theo dõi tình nguyện viên, và báo cáo tác động của các hoạt động.

3. **Xây dựng cộng đồng tích cực**: Tạo điều kiện để mọi người gắn kết, tham gia các hoạt động có ý nghĩa và đóng góp cho xã hội một cách bền vững.

4. **Đơn giản hóa quy trình quản lý tình nguyện**: Loại bỏ các rào cản kỹ thuật bằng cách số hóa quy trình, từ đăng ký, tổ chức đến theo dõi và ghi nhận đóng góp của tình nguyện viên.

Dự án được thực hiện trong cuộc thi [Phần Mềm Nguồn Mở-Olympic Tin học Sinh viên Việt Nam 2024]([https://www.olp.vn/procon-pmmn/ph%E1%BA%A7n-m%E1%BB%81m-ngu%E1%BB%93n-m%E1%BB%9F](https://www.olp.vn/procon-pmmn/ph%E1%BA%A7n-m%E1%BB%81m-ngu%E1%BB%93n-m%E1%BB%9F)). Được open source theo giấy phép [Apache v2.0](https://opensource.org/license/apache-2-0) bởi đội tác giả CTUBase.

## Giới Thiệu

-   

## Chức Năng Chính

Project tập trung vào các chức năng chính như sau:

-   

## 👩‍💻 Tổng Quan Hệ Thống

Backend của hệ thống được thiết kế theo kiến trúc microservices, với các công nghệ sử dụng như sau:

-   

<img loading="lazy" src="./docs/images/system_architecture.svg" alt="Architecture" width="100%" height=600>

## Hướng Dẫn Cài Đặt

### Yêu Cầu 📋

Để cài đặt và chạy được dự án, trước tiên bạn cần phải cài đặt các công cụ bên dưới. Hãy thực hiện theo các hướng dẫn cài đặt sau, lưu ý chọn hệ điều hành phù hợp với máy tính của bạn:
-   [Node JS](https://nodejs.org/en/download/prebuilt-installer)
-   [Windmill CLI](https://docs.docker.com/get-docker/)
-   [SUpabase CLI](https://supabase.com/docs/guides/local-development/cli/getting-started?queryGroups=platform&platform=npx&queryGroups=access-method&access-method=studio)

### 🔨 Cài Đặt

Trước hết, hãy clone dự án về máy tính của bạn:

```bash
git clone https://github.com/CTUbase/OpenHeart.git 
```
sau đó hãy cd đến OpenHeart:
```bash
cd OpenHeart
```
### Chạy backend với Supabase

### Chạy frontend với Windmill
Cài đặt với Windmill cloud:

Đầu tiên, hãy tạo một tài khoản windmill và tạo một workspace với tên **OpenHeart** (bạn có thể tùy chọn tên workspace).

Sau đó, trở về thư mục OpenHeart và làm theo các bước:
1. tạo workspace với tên tương tự tại máy local bằng windmill CLI: 
```bash
wmill workspace add [workspace_name] [workspace_id] [remote_URL]
```
- ví dụ:
```bash
wmill workspace add OpenHeart OpenHeart123 https://app.windmill.dev/
```
2. Terminal sẽ yêu cầu đăng nhập windmill qua browser hoặc token. Để đơn giản, hãy chọn browser, windmill sẽ hiển thị liên kết với trình duyệt để bạn xác nhận.
3. sau khi xác nhận xong, cd đến thư mục */windmill*:
```bash
cd windmill
```
4. Đẩy code lên windmill:
```bash
wmill sync push
```
5. thiết lập varibles với windmill:

........

........

........
### Cài đặt plugin AI trên Windmill
## 🙌 Đóng góp cho dự án

<a href="https://github.com/CTUbase/OpenHeart/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%F0%9F%90%9B+Bug+Report%3A+">Bug Report ⚠️
</a>
<a href="https://github.com/CTUbase/OpenHeart/issues/new?assignees=&labels=&projects=&template=feature_request.md&title=RequestFeature:">Request Feature 👩‍💻</a>

Nếu bạn muốn đóng góp cho dự án, hãy đọc [CONTRIBUTING.md](.github/CONTRIBUTING.md) để biết thêm chi tiết.

Mọi đóng góp của các bạn đều được trân trọng, đừng ngần ngại gửi pull request cho dự án.

## Liên hệ

-   Nguyễn Đăng Khoa: ndkhoa1000@gmail.com
-   Phạm Trí Minh: triminh@gmail.com
-   Nguyễn Đoàn Hoàng Phúc: phuc@gmail.com

## 📝 License

This project is licensed under the terms of the [Apache 2.0](LICENSE) license.

