import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quiz_app/providers/questions_state.dart';

import '../../../constants.dart';

class Option extends StatelessWidget {
  const Option({
    Key key,
    this.text,
    this.index,
    this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionsState>(
        init: QuestionsState(),
        builder: (qState) {
          Color getTheRightColor() {
            if (qState.isAnswered) {
              if (index == qState.correctAns) {
                return kGreenColor;
              } else if (index == qState.selectedAns &&
                  qState.selectedAns != qState.correctAns) {
                return kRedColor;
              }
            }
            return kGrayColor;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
          }

          return InkWell(
            onTap: press,
            child: Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                border: Border.all(color: getTheRightColor()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${index + 1}. $text",
                    style: TextStyle(color: getTheRightColor(), fontSize: 16),
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: getTheRightColor() == kGrayColor
                          ? Colors.transparent
                          : getTheRightColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: getTheRightColor()),
                    ),
                    child: getTheRightColor() == kGrayColor
                        ? null
                        : Icon(getTheRightIcon(), size: 1),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
