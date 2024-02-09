import 'package:chatview2/chatview2.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatController = ChatController(
    initialMessageList: [
      Message(
        id: '1',
        message: "Hi",
        createdAt: DateTime.now(),
        sendBy: '1',
        // replyMessage:
        messageType: MessageType.text,
        title: 'dfjnv',
      ),
      Message(
        id: '2',
        message: "Hello",
        createdAt: DateTime.now(),
        sendBy: '2',
        messageType: MessageType.text,
        title: 'rejn',
      ),
    ],
    scrollController: ScrollController(),
    chatUsers: [ChatUser(id: '2', name: 'Simform')],
  );

  // List<Message> messageList = [
  //   Message(
  //     id: '1',
  //     message: "Hi",
  //     createdAt: DateTime.now(),
  //     sendBy: '1', title: '',
  //   ),
  //   Message(
  //     id: '2',
  //     message: "Hello",
  //     createdAt: DateTime.now(),
  //     sendBy: '2', title: '',
  //   ),
  // ];

  void onSendTap(
      String message, ReplyMessage replyMessage, MessageType messageType) {
    final message = Message(
      id: '3',
      message: "How's you?",
      createdAt: DateTime.now(),
      sendBy: '1',
      replyMessage: replyMessage,
      messageType: messageType,
      title: 'Nalini',
    );

    chatController.addMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ChatView(
              currentUser: ChatUser(id: '1', name: 'Flutter'),
              chatController: chatController,
              onSendTap: onSendTap,
              chatViewState: ChatViewState.hasMessages,
              // Add this state once data is available.
              featureActiveConfig: const FeatureActiveConfig(
                enableSwipeToReply: true,
                enableSwipeToSeeTime: false,
              ),
              appBar: const ChatViewAppBar(
                //profilePicture: profileImage,
                chatTitle: "Simform",
                userStatus: "online",
                actions: [
                  Icon(Icons.more_vert),
                ],
              ),
              chatBackgroundConfig: const ChatBackgroundConfiguration(
                backgroundColor: Colors.white,
                //backgroundImage: backgroundImage,
              ),
              sendMessageConfig: const SendMessageConfiguration(
                replyMessageColor: Colors.grey,
                replyDialogColor: Colors.blue,
                replyTitleColor: Colors.black,
                closeIconColor: Colors.black,
              ),
              chatBubbleConfig: ChatBubbleConfiguration(
                // onDoubleTap: (){
                //   // Your code goes here
                // },
                outgoingChatBubbleConfig: const ChatBubble(
                  // Sender's message chat bubble
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                inComingChatBubbleConfig: ChatBubble(
                  // Receiver's message chat bubble
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              swipeToReplyConfig: SwipeToReplyConfiguration(
                onLeftSwipe: (message, sendBy) {
                  // Your code goes here
                },
                onRightSwipe: (message, sendBy) {
                  // Your code goes here
                },
              ),
              messageConfig: MessageConfiguration(
                messageReactionConfig: MessageReactionConfiguration(),
                // Emoji reaction configuration for single message
                imageMessageConfig: ImageMessageConfiguration(
                  // onTap: (){
                  //   // Your code goes here
                  // },
                  shareIconConfig: ShareIconConfiguration(
                      // onPressed: (){
                      //   // Your code goes here
                      // },
                      ),
                ),
              ),
              reactionPopupConfig: ReactionPopupConfiguration(
                backgroundColor: Colors.white,
                userReactionCallback: (message, emoji) {
                  // Your code goes here
                },
                padding: EdgeInsets.all(12),
                shadow: BoxShadow(
                  color: Colors.black54,
                  blurRadius: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
