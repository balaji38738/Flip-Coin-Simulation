#! /bin/bash -x

#Problem Statement:- Display Winning percentage of Head or Tail Combination in a Singlet, Doublet and Triplet
#Author:- Balaji Ijjapwar
#Date:- 20 March 2020

echo "Flip Coin Simulation"

HEAD=0
TAIL=1

declare -A singletCoinComb	#Stores singlet coin combinations

singletCoinComb=( ["H"]=0 ["T"]=0 )

#Function to generate singlet coin combination
function generateSingletComb() {
   read -p "How many times you want to flip 1 coin: " maxFlips
   for (( flip=0; flip<maxFlips; flip++ ))
   do
      face=$(( RANDOM % 2 ))
      case $face in
      $HEAD) combination="H";;
      $TAIL) combination="T";;
   esac
	singletCoinComb[$combination]=$(( ${singletCoinComb[$combination]} + 1 ))
	done
}

function calcPercent() {
	for comb in "${!singletCoinComb[@]}"
   do
      singletCoinComb[$comb]=`echo "scale=3; ${singletCoinComb[$comb]} * 100 / $maxFlips" | bc`
   done
}

generateSingletComb
calcPercent

echo "Combinations: ${!singletCoinComb[@]}"
echo "Percentages: ${singletCoinComb[@]}"
