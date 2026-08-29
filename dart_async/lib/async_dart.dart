
Future<String> giveMsg() async{
  print("Wait for 2 secs...");
  await Future.delayed(Duration(seconds: 2));
  return "Future code executed successfully";
}

Future<void> msgError() async{
  // print("Error");
  try{
    String result = await giveMsg().timeout(Duration(seconds: 5));
    print(result);
  }
  catch(e){
    print("Future code cannot be executed: $e");
  }
  finally{
    print("Finally block ececuted successfuly");
  }
}

void main() async{
  await msgError();
}