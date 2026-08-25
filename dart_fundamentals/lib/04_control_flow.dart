void main() {
  int score = 85;
  String grade;
  if (score >= 90) {
    grade = 'A';
  } else if (score >= 80) {
    grade = 'B';
  } else if (score >= 70) {
    grade = 'C';
  } else {
    grade = 'F';
  }
  print('Score: $score, Assigned Grade: $grade');

  Object shape = (10, 20);
  switch (shape) {
    case (int w, int h):
      print('Rectangle $w x $h');
    default:
      print('Unknown shape');
  }

  List<String> items = ['A', 'B', 'C'];
  print('Standard for loop:');
  for (int i = 0; i < items.length; i++) {
    print('  Item at index $i: ${items[i]}');
  }

  print('For-in loop:');
  for (var item in items) {
    print('  Item: $item');
  }

  print('While loop (1 to 3):');
  int counter = 1;
  while (counter <= 3) {
    print('  $counter');
    counter++;
  }

  print('Do-while loop:');
  int doCounter = 0;
  do {
    print('  Executed do-while iteration with doCounter = $doCounter');
    doCounter++;
  } while (doCounter < 1);

  print('Loop with continue and break (1 to 10):');
  for (int i = 1; i <= 10; i++) {
    if (i == 5) {
      continue;
    }
    if (i == 8) {
      break;
    }
    print('  $i');
  }

  int speed = 50;
  assert(speed <= 100, "Speed limit exceeded");
  print('Speed assert passed successfully: speed = $speed');
}
