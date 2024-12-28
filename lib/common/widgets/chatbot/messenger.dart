import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
            const ChatScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: Image.asset(
        'assets/logos/chatbot.png',
        fit: BoxFit.cover,
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
  TextEditingController controller = TextEditingController();
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final AllProductController controllerFind = Get.put(AllProductController());
  List<Message> msgs = [];
  bool isTyping = false;
  List<String> allSuggestions = [
    "Sản phẩm bán chạy nhất?",
    "Địa chỉ cửa hàng ở đâu?",
    "Bao lâu tôi có thể nhận được hàng?",
  ];
  List<String> filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    filteredSuggestions = allSuggestions;
    msgs.addAll([
      Message(false, "Xin chào! Tôi là BioLifeBot, tôi có thể giúp gì cho bạn?"),
      Message(false, "Hãy hỏi tôi bất cứ điều gì về dịch vụ của chúng tôi."),
    ]);
  }

  void filterSuggestions(String input) {
    setState(() {
      filteredSuggestions = allSuggestions
          .where((suggestion) =>
          suggestion.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  void sendMsg() async {
    String text = controller.text;
    String apiKey = "AIzaSyBw7v03j6AxrIH_XDFj9GSuV3hrfjscKgc";
    String response = "";

    controller.clear();

    if (text.isNotEmpty) {
      setState(() {
        msgs.add(Message(true, text));
        listKey.currentState?.insertItem(msgs.length - 1);
        isTyping = true;
      });
    }

    if (text.contains("Địa chỉ cửa hàng ở đâu?") || text.contains("địa chỉ")) {
      response =
      "Đây là thông tin địa chỉ của chúng tôi: Số 12, đường Chùa Bộc, Quận Đống Đa, Hà Nội.";
    } else if (text.contains("Bao lâu tôi có thể nhận được hàng?")) {
      response =
      "Sớm nhất 1-2 ngày bạn sẽ nhận được hàng, cửa hàng sẽ liên hệ với bạn khi đơn hàng đến nơi";
    } else if (text.contains("số điện thoại") || text.contains("phone")) {
      response = "Số điện thoại liên hệ của chúng tôi là: 0123456789";
    } else if (text.contains("Sản phẩm bán chạy nhất?")) {
      await controllerFind.filterProductsSaleMax();
      if (controllerFind.products.isNotEmpty) {
        // Cập nhật response với thông tin sản phẩm bán chạy nhất
        response = "Trên đây là các sản phẩm bán chạy nhất của hàng chúng tôi !!!";
        for (var productData in controllerFind.products) {
          String productInfo =
              "- Sản phẩm: ${productData.title}\n"
              "- Giá: ${NumberFormat("#,##0", "vi_VN").format(productData.salePrice)} VND.\n"
              "- Nhà cung cấp: ${productData.brand!.name}\n"
              "- Mô tả: ${productData.description ?? 'Không có mô tả.'}\n";

          setState(() {
            msgs.add(Message(false, productInfo));
            listKey.currentState?.insertItem(msgs.length - 1);
          });
        }
      } else {
        response = "Hiện tại không có sản phẩm bán chạy nhất để hiển thị.";
      }
    }

    if (response.isNotEmpty) {
      setState(() {
        isTyping = false;
        msgs.add(Message(false, response));
        listKey.currentState?.insertItem(msgs.length - 1);
      });
      return;
    }

    await controllerFind.filterProducts(text);
    if (controllerFind.products.isNotEmpty) {
      for (var productData in controllerFind.products) {
        String productInfo =
            "Thông tin sản phẩm:\n- Sản phẩm: ${productData.title}\n"
            "- Giá: ${NumberFormat("#,##0", "vi_VN").format(
            productData.salePrice)} VND.\n"
            "- Nhà cung cấp: ${productData.brand!.name}\n"
            "- Mô tả: ${productData.description ?? 'Không có mô tả.'}";
        setState(() {
          msgs.add(Message(false, productInfo));
          listKey.currentState?.insertItem(msgs.length - 1);
        });
      }
    }

    if (controllerFind.products.isEmpty && text.isNotEmpty) {
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

          if (json != null && json["candidates"] != null &&
              json["candidates"].isNotEmpty) {
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
            content: Text(
                "Lỗi API: ${apiResponse.statusCode} - ${apiResponse.body}"),
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
        title: const Text("BioLifeBot"),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: listKey,
              initialItemCount: msgs.length + (isTyping ? 1 : 0),
              itemBuilder: (context, index, animation) {
                if (isTyping && index == msgs.length) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16, top: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Typing..."),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 5.0,
              runSpacing: 1.0,
              children: filteredSuggestions.map((question) => ActionChip(
                label: Text(
                  question,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
                onPressed: () {
                  controller.text = question;
                  sendMsg();
                },
              )).toList(),
            ),
          ),

          Row(
            children: [

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: controller,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: filterSuggestions,
                      onSubmitted: (value) {
                        sendMsg();
                      },
                      textInputAction: TextInputAction.send,
                      showCursor: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập văn bản",
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: sendMsg,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.send,
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
