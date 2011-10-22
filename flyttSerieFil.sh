#!/bin/bash
tempfolder="/media/raid/temp/"
seriemappe="/media/raid/Serier"
sisteFiler="/media/raid/sisteepisoder"

serier[1]="South.Park"
path[1]="$seriemappe/South Park/Season 15/"
serier[2]="The.Big.Bang.Theory"
path[2]="$seriemappe/The Bigbang Theory/Season 5/"
serier[3]="Boardwalk.Empire"
path[3]="$seriemappe/Boardwalk\ Empire/S2/"
serier[4]="Dexter"
path[4]="$seriemappe/Dexter/Season\ 6/"
serier[5]="Fringe"
path[5]="$seriemappe/Fringe/Season\ 2/"
serier[6]="House"
path[6]="$seriemappe/House\ MD/House\ Season\ 8/"
serier[7]="Hung"
path[7]="$seriemappe/Hung/Season\ 3/"
serier[8]="Sons.of.Anarchy"
path[8]="$seriemappe/Sons\ of\ Anarchy/Season\ 4/"
serier[9]="The.Office"
path[9]="$seriemappe/The\ Office\ US/Season\ 8/"
serier[10]="The.Walking.Dead"
path[10]="$seriemappe/The\ Walking\ Dead/S2/"

cd $tempfolder
for file in `ls` ; do
  lowercasefile=${file,,}
  for serieindex in `seq ${#serier[@]}` ; do
    serie=${serier[$serieindex]}
    lowercaseserie=${serie,,}
    if [[ $lowercasefile = *$lowercaseserie* ]] ; then
       mv $file "${path[$serieindex]}"
       ln -s "${path[$serieindex]}$file" "$sisteFiler/$file"
    fi
  done
done

