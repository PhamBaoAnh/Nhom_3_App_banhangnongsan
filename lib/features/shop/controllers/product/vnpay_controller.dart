import '../../../../common/widgets/vnpay/vnpay.dart'; // Import thư viện VNPay
import 'dart:async'; // Để sử dụng Completer

Future<String> onPayment(double totalAmount) async {
  // Tạo Completer để xử lý bất đồng bộ
  final completer = Completer<String>();

  try {
    // Cấu hình các tham số thanh toán
    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', // vnpay url
      version: '2.0.1',
      tmnCode: '5WW3CDXU', // vnpay tmn code, get from vnpay
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      orderInfo: 'Thanh toán đơn hàng', // order info
      amount: totalAmount,
      returnUrl: 'xxxxxx', // Return URL
      ipAdress: '192.168.10.10',
      vnpayHashKey: 'E3H6Q3TSUPDWB3ADVZN967OLS0QVB5MS', // vnpay hash key
      vnPayHashType: VNPayHashType.HMACSHA512, // hash type
      vnpayExpireDate: DateTime.now().add(const Duration(hours: 1)),
    );

    // Hiển thị giao diện thanh toán VNPay
    await VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (params) {
        // Xử lý khi thanh toán thành công
        String paymentResult = '${params['vnp_ResponseCode']}';
        print('Thanh toán thành công: $paymentResult');
        completer.complete(paymentResult);  // Hoàn thành Completer với kết quả thành công
      },
      onPaymentError: (params) {
        // Xử lý khi thanh toán thất bại
        String paymentResult = '${params['vnp_ResponseCode']}';
        print('Lỗi thanh toán: $paymentResult');
        completer.complete(paymentResult);  // Hoàn thành Completer với kết quả lỗi
      },
    );

    // Chờ cho đến khi có kết quả từ các callback
    return completer.future; // Trả về tương lai kết quả thanh toán
  } catch (e) {
    print('Lỗi trong quá trình thanh toán: $e');
    return 'Payment failed'; // Nếu có lỗi, trả về thông báo thất bại
  }
}
