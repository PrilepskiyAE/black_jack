import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isGameStarted = false;
  final Map<String, int> deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };
  Map<String, int> playingCards = {};
  List<Image> myCards = [];
  List<Image> dealerCards = [];
  String? dealerFirstCard;
  String? dealerSecondCard;

  String? playerFirstCard;
  String? playerSecondCard;

  int dealerScore = 0;
  int playerScore = 0;

  @override
  void initState() {
    playingCards.addAll(deckOfCards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isGameStarted
            ? SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              Text("Dealers score $dealerScore",style: TextStyle(color: dealerScore<=21?Colors.green:Colors.red),),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 200,
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    itemCount: dealerCards.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: dealerCards[index],
                                      );
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Text("Player score $playerScore",style: TextStyle(color: playerScore<=21?Colors.green:Colors.red),),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 200,
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    itemCount: myCards.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: myCards[index],
                                      );
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                      IntrinsicWidth(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MaterialButton(
                              color: Colors.blue[200],
                              onPressed: addCard,
                              child: Text("Another Card"),
                            ),
                            MaterialButton(
                                color: Colors.blue[200],
                                child: const Text("next round"),
                                onPressed: startGame)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: MaterialButton(
                    color: Colors.green[200],
                    child: const Text("Start game"),
                    onPressed: startGame,
                    ),
              ));
  }

  void startGame() {
    setState(() {
      isGameStarted = true;
    });

    playingCards={};
    playingCards.addAll(deckOfCards);

    myCards = [];
    dealerCards = [];
    Random random = Random();
    String cardOneKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardOneKey);

    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardThreeKey);

    String cardFourKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardFourKey);

    dealerFirstCard = cardOneKey;
    dealerSecondCard = cardTwoKey;
    playerFirstCard = cardThreeKey;
    playerSecondCard = cardFourKey;
    dealerCards.add(Image.asset(dealerFirstCard!));
    dealerCards.add(Image.asset(dealerSecondCard!));
    dealerScore = (deckOfCards[dealerFirstCard] ?? 0) +
        (deckOfCards[dealerSecondCard] ?? 0);
    myCards.add(Image.asset(playerFirstCard!));
    myCards.add(Image.asset(playerSecondCard!));
    playerScore = (deckOfCards[playerFirstCard] ?? 0) +
        (deckOfCards[playerSecondCard] ?? 0);
    if(dealerScore <= 14){
      String thirdDealerCardKey=playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => key == thirdDealerCardKey);
      dealerCards.add(Image.asset(thirdDealerCardKey));
      dealerScore=dealerScore+(deckOfCards[dealerSecondCard]?? 0);
    }
  }

  void addCard() {
    Random random = Random();
    if(playingCards.length>0){
    String cardKey =
    playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardKey);
    setState(() {
      myCards.add(Image.asset(cardKey));
      playerScore=playerScore+deckOfCards[cardKey]!;
    });
  }
  }
}
