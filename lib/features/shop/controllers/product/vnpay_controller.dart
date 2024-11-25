

import '../../../../common/widgets/vnpay/vnpay.dart'; // Import thư viện VNPay

Future<bool> onPayment(double totalAmount) async {
  try {
    // Cấu hình các tham số thanh toán
    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url:
      'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
      version: '2.0.1',
      tmnCode: 'W6YEW49O', //vnpay tmn code, get from vnpay
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      orderInfo: 'Thanh toán đơn hàng', //order info, default is Pay Order
      amount: totalAmount,
      returnUrl:
      'xxxxxx', //https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
      ipAdress: '192.168.10.10',
      vnpayHashKey: 'WSBCHHFZBEGYEQNOQHVKLNCGZVHQTHMU', //vnpay hash key, get from vnpay
      vnPayHashType: VNPayHashType
          .HMACSHA512, //hash type. Default is HMACSHA512, you can chang it in: https://sandbox.vnpayment.vn/merchantv2,
      vnpayExpireDate: DateTime.now().add(const Duration(hours: 1)),
    );

    // Hiển thị giao diện thanh toán VNPay
    await VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (params) {
        // Xử lý khi thanh toán thành công
        print('Thanh toán thành công: ${params['vnp_ResponseCode']}');
      },
      onPaymentError: (params) {
        // Xử lý khi thanh toán thất bại
        print('Lỗi thanh toán: ${params['vnp_ResponseCode']}');
      },
    );

    return true; // Giả sử thanh toán thành công
  } catch (e) {
    print('Error during payment process: $e');
    return false; // Nếu có lỗi, trả về false
  }
}


// Thẻ demo để test VNPay

// Ngân hàng: NCB
// Số thẻ: 9704198526191432198
// Tên chủ thẻ:NGUYEN VAN A
// Ngày phát hành:07/15
// Mật khẩu OTP:123456