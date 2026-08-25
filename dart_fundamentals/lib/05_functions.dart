void buildUser(String id, {required String username, String role = "guest"}) {
  print('ID: $id, User: $username, Role: $role');
}

int square(int n) => n * n;

void executeAction(Function action) {
  action();
}

Function makeAdder(int addBy) {
  return (int i) => i + addBy;
}

void main() {
  buildUser("USR-101", username: "Ada Lovelace");
  buildUser("USR-102", username: "Alan Turing", role: "admin");

  print('square(5) = ${square(5)}');

  executeAction(() => print("Executing..."));

  var add5 = makeAdder(5);
  int closureResult = add5(10);
  print('add5(10) = $closureResult');
}
