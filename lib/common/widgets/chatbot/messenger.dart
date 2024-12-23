import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../features/shop/controllers/all_product_controller.dart';
import '../../../utils/constants/colors.dart';
import 'chatbot.dart';

// Widget MessengerIcon
class MessengerIcon extends StatelessWidget {
  const MessengerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        // Khi nhấn vào biểu tượng, chuyển đến màn hình ChatScreen với hiệu ứng fadeIn
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const ChatScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Tạo hiệu ứng fadeIn
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },

      child: Image.asset(
        'assets/logos/chatbot.png',  // Đường dẫn tới hình ảnh trong thư mục assets
        fit: BoxFit.cover,  // Hình ảnh sẽ phủ kín vùng chứa
      ),
    );
  }
}

// Màn hình Chat
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();  // Điều khiển văn bản nhập vào
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>(); // Danh sách tin nhắn có hiệu ứng
  final AllProductController controller_find = Get.put(AllProductController());  // Controller để tìm kiếm sản phẩm
  List<Message> msgs = [];  // Danh sách tin nhắn
  bool isTyping = false;  // Biến kiểm tra trạng thái gõ tin nhắn

  @override
  void initState() {
    super.initState();
    // Khởi tạo tin nhắn chào
    msgs.addAll([
      Message(false, "Xin chào! Tôi là BioLifeBot, tôi có thể giúp gì cho bạn?"),
      Message(false, "Hãy hỏi tôi bất cứ điều gì về dịch vụ của chúng tôi."),
    ]);
  }

  void sendMsg() async {
    String text = controller.text;
    String apiKey = "AIzaSyBw7v03j6AxrIH_XDFj9GSuV3hrfjscKgc";
    String response = ""; // Biến lưu phản hồi

    // Xóa nội dung trong controller
    controller.clear();

    if (text.isNotEmpty) {
      setState(() {
        msgs.add(Message(true, text));
        listKey.currentState?.insertItem(msgs.length - 1);
        isTyping = true;
      });
    }


    bool containsAddressQuestion = text.contains("Địa chỉ của cửa hàng") || text.contains("địa chỉ") || text.contains("địa chỉ của bạn");


    bool containsPhoneQuestion = text.contains("số điện thoại") || text.contains("phone");


    bool containsStoreInfoQuestion = text.contains("Thông tin") || text.contains("cửa hàng");

    // Phản hồi mặc định cho các câu hỏi
    if (containsAddressQuestion) {
      response = "Đây là thông tin địa chỉ của chúng tôi: Số 12, đường Chùa Bộc, Quận Đống Đa, Hà Nội.";
    } else if (containsPhoneQuestion) {
      response = "Số điện thoại liên hệ của chúng tôi là: 0123456789";
    } else if (containsStoreInfoQuestion) {
      response = "Thông tin cửa hàng \n"
                  " + Website:  BioLife.com.vn \n"
                  " + Địa chỉ: Số 12, đường Chùa Bộc, Quận Đống Đa, Hà Nội \n"
                  " + Số điện thoại: 0123456789 \n";
    }

    // Nếu có phản hồi mặc định, gửi tin nhắn này và dừng gọi API
    if (response.isNotEmpty) {
      setState(() {
        isTyping = false;
        msgs.add(Message(false, response));
        listKey.currentState?.insertItem(msgs.length - 1);
      });
      return; // Dừng xử lý phần API nếu đã có phản hồi mặc định
    }

    // Kiểm tra các sản phẩm
    await controller_find.filterProducts(text);

    if (controller_find.products.isNotEmpty) {
      // Duyệt qua tất cả các sản phẩm
      for (var productData in controller_find.products) {
        String productInfo =
            "Thông tin sản phẩm: \n"
            "- Sản phẩm: ${productData.title}\n"
            "- Giá: ${NumberFormat("#,##0", "vi_VN").format(productData.salePrice)} VND.\n"
            "- Nhà cung cấp: ${productData.brand!.name}\n"
            "- Mô tả: ${productData.description ?? 'Không có mô tả.'}\n";

        setState(() {
          msgs.add(Message(false, productInfo));
          listKey.currentState?.insertItem(msgs.length - 1);
        });
      }
    }

    // Nếu không có sản phẩm, gọi API
    if (controller_find.products.isEmpty && text.isNotEmpty) {
      try {
        var apiResponse = await http.post(
          Uri.parse(
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey",
          ),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "contents": [
              {"parts": [{"text": text}]}
            ]
          }),
        );

        if (apiResponse.statusCode == 200) {
          var json = jsonDecode(apiResponse.body);

          if (json != null && json["candidates"] != null && json["candidates"].isNotEmpty) {
            setState(() {
              isTyping = false;
              msgs.add(Message(
                false,
                json["candidates"][0]["content"]["parts"][0]["text"]
                    .toString()
                    .trimLeft(),
              ));
              listKey.currentState?.insertItem(msgs.length - 1);
            });
          } else {
            throw Exception("Dữ liệu từ API không hợp lệ");
          }
        } else {
          setState(() {
            isTyping = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Lỗi API: ${apiResponse.statusCode} - ${apiResponse.body}"),
          ));
        }
      } catch (e) {
        setState(() {
          isTyping = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Lỗi: $e, vui lòng thử lại!"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BioLifeBot"),  // Tiêu đề màn hình chat
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: AnimatedList(
              key: listKey,  // Danh sách tin nhắn có hiệu ứng hoạt hình
              initialItemCount: msgs.length + (isTyping ? 1 : 0),  // Số lượng tin nhắn ban đầu
              itemBuilder: (context, index, animation) {
                if (isTyping && index == msgs.length) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16, top: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Typing..."),  // Hiển thị khi đang gõ
                      ),
                    ),
                  );
                }

                return SizeTransition(
                  sizeFactor: animation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: BubbleNormal(
                      text: msgs[index].msg,
                      isSender: msgs[index].isSender,
                      color: msgs[index].isSender
                          ? Colors.blue.shade100
                          : Colors.grey.shade200,
                    ),
                  ),
                );
              },
            ),
          ),
          // Giao diện gửi tin nhắn
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: controller,  // Điều khiển ô nhập liệu
                      textCapitalization: TextCapitalization.sentences,  // Viết hoa chữ cái đầu câu
                      onSubmitted: (value) {
                        sendMsg();  // Gửi tin nhắn khi nhấn Enter
                      },
                      textInputAction: TextInputAction.send,  // Hành động khi nhấn phím Enter
                      showCursor: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập văn bản",  // Gợi ý văn bản
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: sendMsg,  // Gửi tin nhắn khi nhấn nút gửi
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: TColors.primary,  // Màu nền của nút gửi
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.send,  // Biểu tượng gửi
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}




