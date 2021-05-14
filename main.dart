import 'dart:io';
import 'deck.dart';




void main(){

 print('Welcome to blackjack');
 print('-------------------------------------');
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

    if(userInput == 'y'){
      print('Good luck !\n');
    }else if(userInput == 'n'){
     print('Thanks for playing');
      break;
      }else{
      print('Enter either y or n');
      }
     }
     
   
  // creates deck, player and dealer.
   DeckOfCards deck = DeckOfCards();
   User player1 = User();
   User dealer = User();
   

   //placing bets. if the player bets more than he has he goes all in 
  
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

       //draws 2 cards for player and 1 for dealer
   player1.receiveCard(deck.drawCard());
   player1.receiveCard(deck.drawCard());
   dealer.receiveCard(deck.drawCard());
   int playerSum = sum(player1.hand);
   int dealerSum = sum(dealer.hand);
   
 
   print('\nplayer hand:${player1.hand} ${playerSum}');
   print('Dealer hand:${dealer.hand} ${dealerSum}');
   print('-------------------------------------\n');
   //Callculates the true value of the cards.

    print('player money: $money');
    print('Current pool: $pool');
    print('-------------------------------------');
    

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

