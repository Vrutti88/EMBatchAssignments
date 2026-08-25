sealed class Shape {}

class Square extends Shape {
  final double side;
  Square(this.side);
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

class Rectangle extends Shape {
  final double w, h;
  Rectangle(this.w, this.h);
}

void main() {
  Object response = (statusCode: 200, data: {"user": "Alice"});

  String statusResult = switch (response) {
    (statusCode: 200, data: {'user': String user}) => "Success: $user",
    (statusCode: 404, data: _) => "Not Found",
    (statusCode: int code, data: _) when code >= 500 && code < 600 => "Server Error: $code",
    _ => "Unknown Error",
  };
  print('Switch Expression Result: $statusResult');

  Shape currentShape = Circle(5.0);
  double area = switch (currentShape) {
    Square(:final side) => side * side,
    Circle(:final radius) => 3.14159 * radius * radius,
    Rectangle(:final w, :final h) => w * h,
  };
  print('Calculated Area: $area');

  var entries = [
    (id: 1, info: ['Admin', 'Active']),
    (id: 2, info: ['User', 'Pending']),
  ];

  for (var (id: id, info: [role, ...]) in entries) {
    print('Entry ID: $id, Primary Role: $role');
  }

  outerLoop:
  for (int outer = 1; outer <= 3; outer++) {
    for (int inner = 1; inner <= 3; inner++) {
      if (outer * inner == 4) {
        print('Breaking outerLoop at outer=$outer, inner=$inner');
        break outerLoop;
      }
      print('outer: $outer, inner: $inner');
    }
  }

  int userAge = 20;
  assert(userAge >= 18, "Access denied: User is $userAge years old, minimum required is 18.");
  print('Assertion passed for userAge = $userAge');
}
