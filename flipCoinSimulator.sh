#! /bin/bash -x

#Problem Statement:- Display Winning percentage of Head or Tail Combination in a Singlet, Doublet and Triplet
#Author:- Balaji Ijjapwar
#Date:- 20 March 2020

echo "Flip Coin Simulation"

HEAD=0
TAIL=1

declare -A singletCoinComb	doubletCoinComb tripletCoinComb

#Function to generate singlet coin combination
function generateSingletComb() {
	singletCoinComb=( ["H"]=0 ["T"]=0 )
	maxFlips=$1
	for (( flip=0; flip<maxFlips; flip++ ))
 	do
      face=$(( RANDOM % 2 ))
      case $face in
      	$HEAD) combination="H";;
      	$TAIL) combination="T";;
	  esac
	((singletCoinComb[$combination]+=1))
	done
}

#Function to generate doublet coin combination
function generateDoubletComb() {
	doubletCoinComb=( ["HH"]=0 ["HT"]=0 ["TT"]=0 ["TH"]=0 )
	maxFlips=$1
	for (( flip=0; flip<maxFlips; flip++ ))
    do
		combination=""
		for (( coin=1; coin<=2; coin++ ))
		do
      		face=$(( RANDOM % 2 ))
      		case $face in
				$HEAD) combination="H$combination";;
				$TAIL) combination="T$combination";;
   			esac
		done
   	((doubletCoinComb[$combination]+=1))
	done
}

#Function to generate triplet coin combination
function generateTripletComb() {
   tripletCoinComb=( ["HHH"]=0 ["HHT"]=0 ["HTH"]=0 ["HTT"]=0 ["TTT"]=0 ["THT"]=0 ["TTH"]=0 ["THH"]=0  )
   maxFlips=$1
   for (( flip=0; flip<maxFlips; flip++ ))
   do
      combination=""
      for (( coin=1; coin<=3; coin++ ))
      do
         face=$(( RANDOM % 2 ))
         case $face in
            $HEAD) combination="H$combination";;
            $TAIL) combination="T$combination";;
         esac
      done
      ((tripletCoinComb[$combination]+=1))
   done
}


function calcPercent() {
	coins=$1
	maxFlips=$2
	case $coins in
		1)
			for comb in "${!singletCoinComb[@]}"
   			do
      			singletCoinComb[$comb]=`echo "scale=3; ${singletCoinComb[$comb]} * 100 / $maxFlips" | bc`
   			done
			;;
		2)
			for comb in "${!doubletCoinComb[@]}"
      		do
         		doubletCoinComb[$comb]=`echo "scale=3; ${doubletCoinComb[$comb]} * 100 / $maxFlips" | bc`
      		done
      		;;
		3)
			for comb in "${!tripletCoinComb[@]}"
            do
            	tripletCoinComb[$comb]=`echo "scale=3; ${tripletCoinComb[$comb]} * 100 / $maxFlips" | bc`
         	done
         	;;
	esac
}

function getUserChoice() {
	read -p "How many coins you want flip ? 1 to 3: " noOfCoins
	if [[ $noOfCoins -ne 1 && $noOfCoins -ne 2 && $noOfCoins -ne 3 ]]
	then
		getUserChoice
	else
		read -p "Enter number of flips of each coin: " totalFlips
	fi
}

play="y"	#If user wants to play

while [ $play == "y" ]
do
	getUserChoice
	case $noOfCoins in
      1)
			generateSingletComb $totalFlips
			echo "Combinations: ${!singletCoinComb[@]}"
			echo "Count: ${singletCoinComb[@]}"
			calcPercent $noOfCoins $totalFlips
			echo "Percentage: ${singletCoinComb[@]}";;
      2)
			generateDoubletComb $totalFlips
			echo "Combinations: ${!doubletCoinComb[@]}"
			echo "Count: ${doubletCoinComb[@]}"
         calcPercent $noOfCoins $totalFlips
         echo "Percentage: ${doubletCoinComb[@]}";;
		3)
			generateTripletComb $totalFlips
         echo "Combinations: ${!tripletCoinComb[@]}"
         echo "Count: ${tripletCoinComb[@]}"
         calcPercent $noOfCoins $totalFlips
         echo "Percentage: ${tripletCoinComb[@]}";;
	esac
	read -p "Do you want to continue ?: " play
done
