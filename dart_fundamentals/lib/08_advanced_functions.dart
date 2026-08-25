class APIConfig {
  final String endpoint;
  final int timeoutSeconds;
  final bool enableLogs;

  APIConfig({
    required this.endpoint,
    this.timeoutSeconds = 30,
    this.enableLogs = false,
  });
}

void sendNotification(
  String recipient, {
  String message = "Default Hello",
  bool urgent = false,
  required String sender,
}) {
  print('From: $sender -> To: $recipient | Msg: $message | Urgent: $urgent');
}

List<int> customMap(List<int> list, int Function(int) action) {
  List<int> result = [];
  for (var item in list) {
    result.add(action(item));
  }
  return result;
}

Function createCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

void main() {
  var config = APIConfig(
    endpoint: "https://api.example.com/v1",
    timeoutSeconds: 60,
    enableLogs: true,
  );
  print('APIConfig: endpoint=${config.endpoint}, timeout=${config.timeoutSeconds}s, enableLogs=${config.enableLogs}');

  sendNotification("Bob", sender: "Alice");
  sendNotification("Charlie", message: "Server Maintenance Alert", urgent: true, sender: "SystemAdmin");

  List<int> numbers = [1, 2, 3, 4, 5];
  List<int> squaredList = customMap(numbers, (x) => x * x);
  print('Squared List: $squaredList');

  var counterA = createCounter();
  var counterB = createCounter();

  print('counterA (call 1): ${counterA()}');
  print('counterA (call 2): ${counterA()}');
  print('counterB (call 1): ${counterB()}');
}
