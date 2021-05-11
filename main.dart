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
  
  int numberValue;
  
  Card({this.suit, this.value}){
    
    //.numberValue Callculates the true value of the card. 
    // one = 1, King = 13 and so forward. 
    this.numberValue = this.value.index + 1;
    
  }

 
  
  
 
  //overwrites the toString method 
  
  String toString(){
    
    return suitsToText(this.suit) + " " + cardEnum(this.value);
    
  }
  
  
  //changes the value to string.
  String cardEnum(enumCardValue value){
    
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
      return txt;
    }
  }
  
}

 

 //class for making a deck of cards. 

class DeckOfCards{
  
  List<Card> cards = [];
  
  

  //constructor.
  DeckOfCards(){
      // This loop is used to make each card. Runs 4 times for each suit and 13 times for each value. 
      for(int i = 0; i < 4; i++){
        for(int j = 0; j < 13; j++){
        Card c = Card(suit: enumSuits.values[i], value: enumCardValue.values[j]);
        cards.add(c);
      }
    }
    
    //Shuffels the deck.
    cards.shuffle();
  }
  
  
  
  Card drawCard(){
    
    
    Card cardToReturn = cards[0];
    
    
    cards.remove(cardToReturn);
    
    return cardToReturn;
    
  }
  
  
  String PrintAllCards() {
    for (Card card in this.cards) {
      print(card);
    }
  }

}

 
//user class. Includes hand.
class User {
  
  //Hand starts of as empty. Use the drawcard method to draw a card.
  List<Card> hand = [];
  
  void receiveCard(Card cardgiven){
    hand.add(cardgiven);
  }
  int length(){
    int counter = 0;
    for(int idx = 0; idx< this.hand.length; idx++){
    counter++;
    
    }
  return counter;
  }


}


//Callculates sum of user hand 
int sum(List<Card> L){

int playerSum = 0;
int counter = 0;

  for(Card i in L){
      playerSum = playerSum + L[counter].numberValue;
      counter++;
    }

 return playerSum;
}


int getBet(){
  int i = int.parse(stdin.readLineSync());
  return i;
}

int placeBet(int i){
  i = i * 2;

  return i;
}


void main(){

 print('Welcome to blackjack');
 print('-------------------------------------\n');
 int money = 100;
   int pool = 0;
   int bet;
   String userInput;

 while(money>0){

  //checks if player wants to quit or is broke.
   if(money <= 0){
    print('you are broke');
    print('Thanks for playing !');
    break;
   }else if(money <100 || money > 100){
  
    print('Keep playing ?\nEnter y or n');
    userInput = stdin.readLineSync();

    if(userInput.toLowerCase == 'y'){
      print('Good luck !');
    }else if(userInput.toLowerCase == 'n'){
     print('Thanks for playing');
      break;
      }
     }
     
   
  // creates deck, player and dealer.
   DeckOfCards deck = DeckOfCards();
   User player1 = User();
   User dealer = User();
   

   //draws 2 cards for player and 1 for dealer
   player1.receiveCard(deck.drawCard());
   player1.receiveCard(deck.drawCard());
   dealer.receiveCard(deck.drawCard());
   
 
   print('\nplayer hand:${player1.hand}');
   print('Dealer hand:${dealer.hand}');
   print('-------------------------------------\n');
   //Callculates the true value of the cards.
   int playerSum = sum(player1.hand);
   int dealerSum = sum(dealer.hand);
   
   print('Current player sum ${playerSum}');
   print('Current dealer sum ${dealerSum}');
   print('-------------------------------------\n');

   //placing bets. if the player bets more than he has he goes all in 
   //crashes if letters are used. Will fix.
    print('place your bet !');
    print('your money: $money');
    int bet = getBet();
     if(bet > money){
       print('ALL INN !');
         pool = money;
         money = 0;
     }else{
      pool = placeBet(bet);
      money -= bet;
     }

    
    print('player money: $money');
    print('Current pool: $pool');
    
    //Game starts
    while(true){
     print('draw a card or stay ?');
     String userInput = stdin.readLineSync();

     if(userInput == 'draw'){
      player1.receiveCard(deck.drawCard());
      print('-------------------------------------');
      print('player hand:${player1.hand}');
      playerSum = sum(player1.hand);
      print('-------------------------------------\n');
      print('Current player sum ${playerSum}');
        if(playerSum > 21){
          print('----------Bust!------------------');
          break;
        }
      }
      else if(userInput == 'stay'){
        print('Dealer will now draw');
        dealerSum = sum(dealer.hand);
        //dealer draws until he is at or over 17
        while(dealerSum <=17){
          dealer.receiveCard(deck.drawCard());
          dealerSum = sum(dealer.hand);
         }

          print('${dealer.hand} ${dealerSum}'); 
          if(playerSum > dealerSum || playerSum == 21 || dealerSum > 21 ){
          print('----------your win !--------------');
          money = money + pool;
          break;

          }
          else if(playerSum < dealerSum || dealerSum == 21){
          print('------------you lose !-------------');
          pool = 0;
          break;
          
         }
         else if(playerSum == dealerSum){
          print('Push !');
          money = money + bet;
          pool = 0;
          break;
          
         }
         
      }else{
      print('Enter either draw or stay');
      }
    }
   }
   print('Hope to see you again ');
}




  /*for(Card i in player1.hand){
      playerSum = playerSum + player1.hand[counter].numberValue;
      counter++;
    }

    counter++;
    print(counter);
    */