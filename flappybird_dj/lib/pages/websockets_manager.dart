import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart';

enum ConnectionStatus {
  disconnected,
  disconnecting,
  connecting,
  connected
}

class WebSocketsHandler {
  late Function _callback;
  String ip = "localhost";

  IOWebSocketChannel? _socketClient;
  ConnectionStatus connectionStatus = ConnectionStatus.disconnected;

  String? mySocketId;

  void connectToServer(String serverIp,String name, void Function(String message) callback) async {
    //connection settings
    _callback = callback;
    ip = serverIp;

    // Connect to server
    connectionStatus = ConnectionStatus.connecting;

    // Simulate connection delay
    await Future.delayed(const Duration(seconds: 1));

    _socketClient = IOWebSocketChannel.connect("ws://$ip");
    _socketClient!.stream.listen(
      (message) { 
        if (connectionStatus != ConnectionStatus.connected) {
          connectionStatus = ConnectionStatus.connected;
        }
        _callback(message);
      },
      onError: (error) {
        connectionStatus = ConnectionStatus.disconnected;
        mySocketId = "";
        print("Error WebSocketHandler: $error\n");
      },
      onDone: () {
        connectionStatus = ConnectionStatus.disconnected;
        mySocketId = "";
        print("Done WebSocketHandler\n");
        sendMessage('{ "type": "init", "name": $name }');
      },
    );
  }

  void sendMessage(String message) {
    if (connectionStatus != ConnectionStatus.connected) {
      return;
    }
    print("Sending message: $message");
    _socketClient!.sink.add(message);
  }

  disconnectFromServer() async {
    connectionStatus = ConnectionStatus.disconnecting;

    await Future.delayed(const Duration(seconds: 1));

    _socketClient!.sink.close();
  }
}
