import 'package:flutter/material.dart';

class BottomChatBar extends StatelessWidget {
  const BottomChatBar({
    super.key,
    required this.onSend,
    required this.controller,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 1,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            height: 60,
            width: 60,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: controller.text.isEmpty
                    ? null
                    : () async {
                        onSend();
                        controller.clear();
                      },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.send,
                    color: controller.value.text.isEmpty
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
