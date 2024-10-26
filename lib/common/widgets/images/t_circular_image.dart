import 'package:flutter/material.dart';

// Import các file utils chứa các hằng số và hàm trợ giúp
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

// Widget TCircularImage hiển thị một hình ảnh dạng tròn
class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit = BoxFit.cover, // Mặc định là BoxFit.cover để hình ảnh bao phủ toàn bộ
    required this.image, // Chuỗi ảnh, có thể là URL hoặc tên asset
    required this.isNetworkImage, // Để xác định là ảnh từ network hay từ assets
    this.overlayColor, // Màu phủ lên ảnh
    this.backgroundColor, // Màu nền cho container chứa ảnh
    this.width = 56, // Chiều rộng mặc định của container
    this.height = 56, // Chiều cao mặc định của container
    this.padding = TSizes.sm,  // Padding mặc định xung quanh ảnh
  });

  final BoxFit? fit; // Kiểu fit của ảnh (ví dụ: cover, contain, v.v.)
  final String image; // Đường dẫn ảnh (URL hoặc asset)
  final bool isNetworkImage; // Xác định kiểu ảnh (network hoặc asset)
  final Color? overlayColor; // Màu phủ lên ảnh
  final Color? backgroundColor; // Màu nền của container
  final double width, height, padding; // Kích thước và padding của container

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding), // Padding được set từ constructor
      decoration: BoxDecoration(
        // Sửa điều kiện cho `backgroundColor` vì `backgroundColor` là một `Color?`
        color: backgroundColor ??
            (THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white),
        borderRadius: BorderRadius.circular(100), // Bo tròn container (100 cho hình tròn)
      ),
      child: Image(
        // Xác định kiểu ảnh từ mạng hoặc từ asset
        image: isNetworkImage
            ? NetworkImage(image) as ImageProvider // Dùng NetworkImage cho ảnh từ URL
            : AssetImage(image) as ImageProvider, // Dùng AssetImage cho ảnh từ assets
        color: overlayColor, // Áp dụng màu phủ (nếu có)
        fit: fit, // Đặt kiểu fit cho ảnh
      ),
    );
  }
}
