#!/bin/bash
# TODO: Modify this file to create a shell script that is able to use awk to go through a file formatted like pokemon.dat and provides a printed report in the following format (where your script correctly calculates the values that go into the [VALUE] placeholders):
# ===== SUMMARY OF DATA FILE =====
#    File name: [VALUE]
#    Total Pokemon: [VALUE]
#    Avg. HP: [VALUE]
#    Avg. Attack: [VALUE]
# ===== END SUMMARY =====

# The "Avg." values should be calculated as mean values for the corresponding columns.
# The spacing and header formatting should match the above formatting description exactly.
# There should be a comment explaining the purpose of each line in your shell script. 
# The data file will be passed in to the script as a positional parameter and will not necessarily be called pokemon.dat. However, you can assume that any file passed to this script will be formatted exactly the way pokemon.dat is formatted.
FILENAME=$1 #Sets filename to the first param after script call
TOTALPKMN=$(gawk 'END {print NR-1}' ${FILENAME} ) # finds number of lines minus the header for number of pokemon
TOTALHP=$(gawk '(NR>1) {numCount = 0; for( i=1; i < NF; i++){if( $i ~ /^[0-9]+$/){ numCount += 1;} if( numCount == 2){sum += $i}}} END{print sum}' ${FILENAME}) # finds the second field with a number in it and adds to the total, returning it to this variable
echo $TOTALHP
AVGHP=$(gawk -v x=$TOTALHP -v y=$TOTALPKMN 'BEGIN { print (x/y) }') # divides the total by the number of pokemon for the average
TOTALATTACK=$(gawk '(NR>1) {numCount = 0; for( i=1; i < NF; i++){if( $i ~ /^[0-9]+$/){ numCount += 1;} if( numCount == 3){sum += $i}}} END{print sum}' ${FILENAME}) # finds the third field with a number in it and adds to the total, returning the total to this varaible
AVGATTACK=$(gawk -v x=$TOTALATTACK -v y=$TOTALPKMN 'BEGIN { print (x/y) }') # divides the total by the number of pokemon to find the average

echo "===== SUMMARY OF DATA FILE ====="
echo "   File name: ${FILENAME}"
echo "   Total Pokemon: ${TOTALPKMN}"
echo "   Avg. HP: ${AVGHP}"
echo "   Avg. Attack ${AVGATTACK}"
echo "===== END SUMMARY ====="
