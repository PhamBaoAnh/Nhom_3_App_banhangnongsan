import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Đăng nhập thất bại', (WidgetTester tester) async {
    // Khởi chạy ứng dụng
    app.main();
    await tester.pumpAndSettle();

    await tester.pumpAndSettle(Duration(seconds: 5)); // Giả sử logo tồn tại 3 giây
    // Nhấn nút "Skip" để chuyển đến trang đăng nhập
    final skipButton = find.byType(ElevatedButton);


    for (int i = 0; i < 3; i++) {
      expect(skipButton, findsOneWidget);
      await tester.tap(skipButton);
      await tester.pumpAndSettle();
    }
    // In cây giao diện sau khi nhấn Skip
    final emailField = find.byKey(Key('emailField'));
    expect(emailField, findsOneWidget);

    // Nhập email vào trường email
    await tester.enterText(emailField, 'minhnv1019@gmail.com');
    await tester.pumpAndSettle();

    // Tìm trường nhập mật khẩu bằng Key 'passwordField'
    final passwordField = find.byKey(Key('passwordField'));
    expect(passwordField, findsOneWidget);

    // Nhập mật khẩu vào trường mật khẩu
    await tester.enterText(passwordField, '1234');

    // Ẩn bàn phím
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    // Nhấn nút "Sign In"
    final signInButton = find.byType(ElevatedButton);
    expect(signInButton, findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(signInButton);
    await tester.tap(signInButton);
    // Đợi thông báo lỗi từ Get.snackbar
    await tester.pumpAndSettle(Duration(seconds: 2));

    // Kiểm tra thông báo lỗi
    // Tìm widget hiển thị thông báo lỗi từ Get.snackbar
    final errorText = find.text('Login Failed');
    expect(errorText, findsOneWidget);
  });

}
