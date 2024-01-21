import 'package:flutter/material.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool ohturn = true;
  List<String> displayxo = ['', '', '', '', '', '', '', '', ''];
  var mytextstyle = TextStyle(color: Colors.white, fontSize: 28);
  int Xscore = 0;
  int Oscore = 0;
  int draw = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player O', style: mytextstyle),
                        Text(Oscore.toString(), style: mytextstyle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player X', style: mytextstyle),
                        Text(Xscore.toString(), style: mytextstyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    child: Center(
                      child: Text(
                        displayxo[index],
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohturn && displayxo[index] == '') {
        displayxo[index] = 'O'; // Use uppercase 'O'
        draw += 1;
      } else if (!ohturn && displayxo[index] == '') {
        displayxo[index] = 'X'; // Use uppercase 'X'
        draw += 1;
      }
      ohturn = !ohturn;
      _checkwin();
    });
  }

  void _checkwin() {
    if (displayxo[0] == displayxo[1] &&
        displayxo[0] == displayxo[2] &&
        displayxo[0] != '') {
      _showwin(displayxo[0]);
    }
    if (displayxo[3] == displayxo[4] &&
        displayxo[3] == displayxo[5] &&
        displayxo[3] != '') {
      _showwin(displayxo[3]);
    }
    if (displayxo[6] == displayxo[7] &&
        displayxo[6] == displayxo[8] &&
        displayxo[6] != '') {
      _showwin(displayxo[6]);
    }
    if (displayxo[0] == displayxo[3] &&
        displayxo[0] == displayxo[6] &&
        displayxo[0] != '') {
      _showwin(displayxo[0]);
    }
    if (displayxo[1] == displayxo[4] &&
        displayxo[1] == displayxo[7] &&
        displayxo[1] != '') {
      _showwin(displayxo[1]);
    }
    if (displayxo[2] == displayxo[5] &&
        displayxo[2] == displayxo[8] &&
        displayxo[2] != '') {
      _showwin(displayxo[2]);
    }
    if (displayxo[6] == displayxo[4] &&
        displayxo[6] == displayxo[2] &&
        displayxo[6] != '') {
      _showwin(displayxo[6]);
    }
    if (displayxo[0] == displayxo[4] &&
        displayxo[0] == displayxo[8] &&
        displayxo[0] != '') {
      _showwin(displayxo[0]);
    } else if (draw == 9) {
      _showdraw();
    }
  }

  void _showdraw() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('DRAW'),
          actions: [
            ElevatedButton(
              child: Text('Play again'),
              onPressed: () {
                _clearboard();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _showwin(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Winner is ' + winner),
          actions: [
            ElevatedButton(
              
              child: Text('Play again'),
              onPressed: () {
                _clearboard();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
    if (winner == 'O') {
      Oscore += 1;
    } else if (winner == 'X') {
      Xscore += 1;
    }

    // Check if either player has won three times
    if (Oscore == 3 || Xscore == 3) {
      _resetScores();
    }
  }

  void _resetScores() {
    setState(() {
      Oscore = 0;
      Xscore = 0;
    });
  }

  void _clearboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayxo[i] = '';
      }
      draw = 0;
    });
  }
}
