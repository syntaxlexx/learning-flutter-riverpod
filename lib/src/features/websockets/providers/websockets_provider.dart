import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const wsUrl = kIsWeb ? 'ws://127.0.0.1:8080' : 'ws://10.0.2.2:8080';

final messagesProvider = StreamProvider.autoDispose<String>((ref) async* {
  // open connection
  final channel = kIsWeb
      ? WebSocketChannel.connect(Uri.parse(wsUrl))
      : IOWebSocketChannel.connect(Uri.parse(wsUrl));

  // close connectioon when stream is destroyed
  ref.onDispose(() => channel.sink.close());

  channel.sink.add('send_something');

  // parse value received and emit message instance
  await for (final value in channel.stream) {
    yield value.toString();
  }
});
