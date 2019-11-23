import 'dart:async';
import 'dart:math';

Future<void> main() async {
    final random = Random();
    await Future<int>.delayed(Duration(milliseconds:  random.nextInt(10)), handleRequest);
    await Future<int>.delayed(Duration(milliseconds:  random.nextInt(10)), handleRequest);
}

FutureOr<int> handleRequest(){
    final random = Random();
    if(random.nextInt(10) < 5){
        throw Error();
    }
    return null;
}
