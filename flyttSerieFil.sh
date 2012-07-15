#!/bin/bash
tempfolder="/media/raid/temp/"
seriemappe="/media/raid/Serier"
sisteFiler="/media/raid/sisteepisoder"

serier[1]="South.Park"
path[1]="$seriemappe/South Park/Season 15/"
serier[2]="The.Big.Bang.Theory"
path[2]="$seriemappe/The Bigbang Theory/Season 5/"
serier[3]="Boardwalk.Empire"
path[3]="$seriemappe/Boardwalk Empire/S2/"
serier[4]="Dexter"
path[4]="$seriemappe/Dexter/Season 6/"
serier[5]="Futurama"
path[5]="$seriemappe/Futurama/Season 7/"
serier[6]="House.of.Lies"
path[6]="$seriemappe/House of lies/S1/"
serier[7]="House"
path[7]="$seriemappe/House MD/House Season 8/"
serier[8]="Hung"
path[8]="$seriemappe/Hung/Season 3/"
serier[9]="Sons.of.Anarchy"
path[9]="$seriemappe/Sons of Anarchy/Season 4/"
serier[10]="The.Office"
path[10]="$seriemappe/The Office US/Season 8/"
serier[11]="The.Walking.Dead"
path[11]="$seriemappe/The Walking Dead/S2/"
serier[12]="Californication"
path[12]="$seriemappe/Californication/Season 5/"
serier[13]="30.Rock"
path[13]="$seriemappe/30 Rock/Season 6/"
serier[14]="Justified"
path[14]="$seriemappe/Justified/S3/"
serier[15]="Parks.and.Recreation"
path[15]="$seriemappe/Parks and recreation/S4/"
serier[16]="Archer"
path[16]="$seriemappe/Archer/S3/"
serier[17]="True.Blood"
path[17]="$seriemappe/True Blood/Season 5/"
serier[18]="Mad.Men"
path[18]="$seriemappe/Mad Men/Season 5/"
serier[19]="Louie"
path[19]="$seriemappe/Louie/S3/"
serier[20]="Burn.Notice"
path[20]="$seriemappe/Burn Notice/Season 6/"
serier[21]="Weeds"
path[21]="$seriemappe/Weeds/S8/"
serier[22]="The.Newsroom"
path[22]="$seriemappe/The Newsroom/S1/"

export DISPLAY=:0.0

cd $tempfolder
for file in `ls` ; do
  lowercasefile=${file,,}
  for serieindex in `seq ${#serier[@]}` ; do
    serie=${serier[$serieindex]}
    lowercaseserie=${serie,,}
    if [[ $lowercasefile = *$lowercaseserie* ]] ; then
       mv $file "${path[$serieindex]}"
       SYMLINK="$sisteFiler/$file"
       ln -s "${path[$serieindex]}$file" $SYMLINK
       echo "ln -s "${path[$serieindex]}$file" $SYMLINK"
       vlc $SYMLINK &
       echo "vlc $SYMLINK &"
    fi
  done
done

exit
