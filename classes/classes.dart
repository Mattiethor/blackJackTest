import 'dart:io';

enum enumSuits {
  clubs,
  diamonds,
  hearts,
  spades,
}

enum enumCardValue {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  joker,
  queen,
  king,
}

//class for card. Uses the enum CardValue and suit to create a card.

class Card {
  enumCardValue value;

  enumSuits suit;

  int? numberValue;

  Card({required this.suit, required this.value}) {
    //.numberValue Calculates the true value of the card.
    // one = 1, King = 13 and so forward.
    this.numberValue = this.value.index + 1;
  }

  //overwrites the toString method

  String toString() {
    return suitsToText(this.suit) + " " + cardEnum(this.value);
  }

  //changes the value to string.
  String cardEnum(enumCardValue value) {
    return value.toString().split('.')[1];
  }

  //changes the enumSuits to strings and the aroppopiet icon.
  String suitsToText(enumSuits suits) {
    String txt = suits.toString().split('.')[1];
    if (suits == enumSuits.clubs) {
      txt = '♣';
      return txt;
    } else if (suits == enumSuits.diamonds) {
      txt = '♦';
      return txt;
    } else if (suits == enumSuits.hearts) {
      txt = '♥';
      return txt;
    } else if (suits == enumSuits.spades) {
      txt = '♠';
    }
    return txt;
  }
}

//class for making a deck of cards.

class DeckOfCards {
  List<Card> cards = [];

  //constructor.
  DeckOfCards() {
    // This loop is used to make each card. Runs 4 times for each suit and 13 times for each value.
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 13; j++) {
        Card c =
            Card(suit: enumSuits.values[i], value: enumCardValue.values[j]);
        cards.add(c);
      }
    }

    //Shuffels the deck.
    cards.shuffle();
  }

  Card drawCard() {
    Card cardToReturn = cards[0];

    cards.remove(cardToReturn);

    return cardToReturn;
  }

  void PrintAllCards() {
    for (Card card in this.cards) {
      print(card);
    }
  }
}

//user class. Includes hand.
class User {
  //Hand starts of as empty. Use the drawcard method to draw a card.
  List<Card> hand = [];

  void receiveCard(Card cardgiven) {
    hand.add(cardgiven);
  }

  int length() {
    int counter = 0;
    for (int idx = 0; idx < this.hand.length; idx++) {
      counter++;
    }
    return counter;
  }
}

//Callculates sum of user hand
int? sum(List<Card> L) {
  int? playerSum = 0;
  int counter = 0;

  for (Card i in L) {
    playerSum = playerSum! + L[counter].numberValue!;
    counter++;
  }

  return playerSum;
}

int getBet() {
  while (true) {
    try {
      int i = int.parse(stdin.readLineSync()!);
      return i;
    } on FormatException {
      print('Only use whole numbers');
    }
  }
}

int placeBet(int i) {
  i = i * 2;

  return i;
}
