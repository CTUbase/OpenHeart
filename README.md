# OpenHeart
[![Github license](https://img.shields.io/github/license/CTUbase/OpenHeart.svg 'Github license')](https://github.com/CTUbase/OpenHeart/blob/master/LICENSE)
[![Open issues](https://img.shields.io/github/issues/CTUbase/OpenHeart.svg 'Open issues')](https://github.com/CTUbase/OpenHeart/issues)
[![Open Pull Requests](https://img.shields.io/github/issues-pr/CTUbase/OpenHeart.svg 'Open Pull Requests')](https://github.com/CTUbase/OpenHeart/pulls)
[![Commit activity](https://img.shields.io/github/commit-activity/m/CTUbase/OpenHeart.svg 'Commit activity')](https://github.com/CTUbase/OpenHeart/graphs/commit-activity)
[![GitHub contributors](https://img.shields.io/github/contributors/CTUbase/OpenHeart.svg 'Github contributors')](https://github.com/CTUbase/OpenHeart/graphs/contributors)
![](./docs/images/new_banner.png)

![](./docs/images/vbqppl.png)

![](./docs/images/qna.png)

# OpenHeart [![Demo](https://img.shields.io/badge/Demo-2ea44f?style=for-the-badge)](http://vnlaw.japaneast.cloudapp.azure.com) [![Documentation](https://img.shields.io/badge/Documentation-blue?style=for-the-badge)]()

<a href="https://github.com/CTUbase/OpenHeart/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%F0%9F%90%9B+Bug+Report%3A+">Bug Report ⚠️
</a>

<a href="https://github.com/CTUbase/OpenHeart/issues/new?assignees=&labels=&projects=&template=feature_request.md&title=RequestFeature:">Request Feature 👩‍💻</a>

Ứng dụng hỗ trợ ...

Mục tiêu là phát triển một hệ thống ...

Dự án được thực hiện trong cuộc thi [Phần Mềm Nguồn Mở-Olympic Tin học Sinh viên Việt Nam 2024]([https://www.olp.vn/procon-pmmn/ph%E1%BA%A7n-m%E1%BB%81m-ngu%E1%BB%93n-m%E1%BB%9F](https://www.olp.vn/procon-pmmn/ph%E1%BA%A7n-m%E1%BB%81m-ngu%E1%BB%93n-m%E1%BB%9F)). Được được open source theo giấy phép [Apache v2.0](https://opensource.org/license/apache-2-0) bởi đội tác giả CTUBase.

Để biết thêm chi tiết về cuộc thi, bạn có thể xem tại [đây](https://www.olp.vn/procon-pmmn/ph%E1%BA%A7n-m%E1%BB%81m-ngu%E1%BB%93n-m%E1%BB%9F).

Link thuyết trình Canva tại cuộc thi [link]()

Slide bài thuyết trình tại cuộc thi dưới dạng PDF có thể được truy cập tại đây: [Slide]()

## 🔎 Danh Mục

1. [Giới Thiệu](#Giới-Thiệu)
2. [Chức Năng](#chức-năng-chính)
3. [Tổng Quan Hệ Thống](#👩‍💻-tổng-quan-hệ-thống)
4. [Cấu Trúc Thư Mục](#cấu-trúc-thư-mục)
5. [Hướng Dẫn Cài Đặt](#hướng-dẫn-cài-đặt)
    - [📋 Yêu Cầu - Prerequisites](#yêu-cầu-📋)
    - [🔨 Cài Đặt](#🔨-cài-đặt)
6. [CI/CD](#ci/cd)
7. [🙌 Đóng Góp](#🙌-đóng-góp-cho-dự-án)
8. [📝 License](#📝-license)

## Giới Thiệu

-   

## Chức Năng Chính

Project tập trung vào các chức năng chính như sau:

-   

## 👩‍💻 Tổng Quan Hệ Thống

Backend của hệ thống được thiết kế theo kiến trúc microservices, với các công nghệ sử dụng như sau:

-   

<img loading="lazy" src="./docs/images/system_architecture.svg" alt="Architecture" width="100%" height=600>

### CI/CD

Project CI/CD sử dụng Github và [Github Actions](https://docs.github.com/en/actions) để tự động hóa quá trình build và deploy. Quy trình như hình vẽ sau:

![CI/CD](./docs/images/ci_cd.svg)

Các workflows của project được lưu tại: [.github/workflows](.github/workflows), với các workflow như sau:

-   [build-docker.yaml](.github/workflows/build-docker.yaml): Build docker image cho các service và push lên docker hub
-   [build-docker-github.yaml](.github/workflows/build-docker-github.yaml): Build docker image cho các service và push lên github packages
-   [build-documentation.yaml](.github/workflows/build-documentation.yaml): Build documentation và push lên github pages

## Cấu trúc thư mục

-   

## Hướng Dẫn Cài Đặt

Tất cả các images build từ services backend bạn có thể tìm thấy tại [Docker Hub]().

### Yêu Cầu 📋

Để cài đặt và chạy được dự án, trước tiên bạn cần phải cài đặt các công cụ bên dưới. Hãy thực hiện theo các hướng dẫn cài đặt sau, lưu ý chọn hệ điều hành phù hợp với máy tính của bạn:

-   [Docker-Installation](https://docs.docker.com/get-docker/)
-   [Docker-Compose-Installation](https://docs.docker.com/compose/install/)
-   [NodeJS v18-Installation](https://nodejs.org/en/download/)

> **Lưu ý:** NextJS 14 chỉ tương thích với NodeJS từ version 18 trở lên.

### 🔨 Cài Đặt

Trước hết, hãy clone dự án về máy tính của bạn:

```bash
git clone https://github.com/CTUbase/OpenHeart.git 
```

### Chạy backend hệ thống
### Chạy frontend hệ thống
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
