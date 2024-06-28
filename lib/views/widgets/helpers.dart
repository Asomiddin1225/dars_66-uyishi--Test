import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dars_66/controllers/test_controller.dart';

class TestHelpers {
  static void checkAnswer(String answer, String correctAnswer, int control1,
      int control2, Function(int, int) updateControl) {
    if (answer == correctAnswer) {
      control1++;
    } else {
      control2++;
    }
    updateControl(control1, control2);
  }

  static Future<void> nextQuestion(
      BuildContext context,
      AnimationController controller,
      int currentIndex,
      Function(int) updateIndex) async {
    final snapshot =
        await Provider.of<TestControllers>(context, listen: false).list.first;
    final length = snapshot.docs.length;

    if (currentIndex < length - 1) {
      await controller.forward();
      updateIndex(currentIndex + 1);
      await controller.reverse();
    } else {
      updateIndex(currentIndex + 1);
    }
  }

  static void restartTest(Function(int, int, int) resetState) {
    resetState(0, 0, 0);
  }
}
