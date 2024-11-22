import 'package:encaixado/domain/extensions/string_buffer_extentsion.dart';
import 'package:encaixado/domain/extensions/string_extension.dart';
import 'package:letter_boxed_engine/letter_boxed_engine.dart';

class GameController {
  GameController({required this.box, required this.engine});

  final Box box;
  final LetterBoxedEngine engine;

  final StringBuffer _wordBuffer = StringBuffer();
  final List<String> _wordList = [];

  List<String> get wordList => _wordList;
  String get word => _wordBuffer.toString();

  void addChar(String char) {
    assert(char.length == 1);

    if (!('$_wordBuffer$char').contains(box.denied)) _wordBuffer.write(char);
  }

  void deleteLastChar() {
    if (_wordList.isEmpty) {
      if (_wordBuffer.isEmpty) return;
      _wordBuffer.removeLast();
    } else {
      if (_wordBuffer.length > 1) {
        _wordBuffer.removeLast();
      } else {
        _wordBuffer.clear();
        _wordBuffer.write(_wordList.last);
        _wordList.removeLast();
      }
    }

    // setStateCallback();
  }

  void restartGame() {
    _wordBuffer.clear();
    _wordList.clear();

    // setStateCallback();
  }

  /// check if word contains denied char sequences
  /// check if dictionary contains word
  ///
  /// if word is valid, add it to word sequence (uninplemented)
  void validate() {
    final currentWord = _wordBuffer.toString();
    if (engine.validateWord(currentWord, box)) {
      print('valid word');
      final last = currentWord.lastChar;
      _wordList.add(currentWord);
      _wordBuffer.clear();
      _wordBuffer.write(last);
    } else {
      /// TODO: implement
      /// notify user
      print('$currentWord is not a valid word');
    }

    // check if game ended
    if (_wordList.join().split('').toSet().length >= 12) {
      print(_wordList);
      if (engine.validateSolution(_wordList, box)) {
        print('YOU WON');
      }
    }

    // setStateCallback();
  }
}
