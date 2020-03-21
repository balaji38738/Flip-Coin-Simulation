#! /bin/bash -x

#Problem Statement:- Display Winning percentage of Head or Tail Combination in a Singlet, Doublet and Triplet
#Author:- Balaji Ijjapwar
#Date:- 20 March 2020

echo "Flip Coin Simulation"

HEAD=0
TAIL=1

face=$(( RANDOM % 2 ))
case $face in
	0)	echo "Head";;
	1) echo "Tail";;
esac
