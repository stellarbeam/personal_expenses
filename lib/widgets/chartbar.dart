import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String dayLabel;
  final double totalSpending;
  final double spendingProportion;

  ChartBar({
    @required this.dayLabel,
    @required this.totalSpending,
    @required this.spendingProportion,
  });

  String get minifiedTotalSpending {
    var amount = totalSpending.round();
    if (amount >= 1000) {
      return '${(totalSpending / 1000).toStringAsFixed(1)}k';
    } else {
      return '${totalSpending.toStringAsFixed(0)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$$minifiedTotalSpending'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.60,
            width: 10,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingProportion,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('$dayLabel'),
            ),
          ),
        ],
      );
    });
  }
}
