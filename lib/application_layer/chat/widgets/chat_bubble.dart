import 'package:echo_chat/domain_layer/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final Message message;

  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        final curvedValue = Curves.easeOutCubic.transform(value);
        final curvedValueEaseIn = Curves.easeInCubic.transform(value);
        return Opacity(
          opacity: curvedValueEaseIn,
          child: Transform.translate(
            offset: Offset((message.isMe ? 100 : -100) * (1 - curvedValue), 0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 140),
              child: Container(
                decoration: BoxDecoration(
                  color: message.isMe
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 240),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.username,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: message.isMe
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5)
                                      : Colors.grey[400],
                                ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(message.message)),
                              Text(
                                "${message.time.hour}:${message.time.minute}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: message.isMe
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.5)
                                          : Colors.grey[400],
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
