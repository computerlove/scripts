#!/bin/bash
tempfolder="/media/raid/temp/"
seriemappe="/media/raid/Serier"
sisteFiler="/media/raid/sisteepisoder"

serier=()
serier+=("American.Horror.Story")
serier+=("Ash.vs.Evil.Dead")
serier+=("Archer")
serier+=("Banshee")
serier+=("Boardwalk.Empire")
serier+=("Californication")
serier+=("Community")
serier+=("Cosmos")
serier+=("Derek")
serier+=("Doctor.Who")
serier+=("Doctor_Who")
serier+=("Falling.Skies")
serier+=("Fargo")
serier+=("Game.of.Thrones")
serier+=("Girls")
serier+=("Halt.and.Catch.Fire")
serier+=("Hannibal")
serier+=("House.of.Lies")
serier+=("Homeland")
serier+=("Its.Always.Sunny.in.Philadelphia")
serier+=("Justified")
serier+=("Louie")
serier+=("Mad.Men")
serier+=("Mr.Robot")
serier+=("MrRobot")
serier+=("Parks.and.Recreation")
serier+=("Rectify")
serier+=("Silicon.Valley")
serier+=("Shameless")
serier+=("Suits")
serier+=("Sons.of.Anarchy")
serier+=("South.Park")
serier+=("The.Americans")
serier+=("The.Big.Bang.Theory")
serier+=("The.Knick")
serier+=("The.Newsroom")
serier+=("The.Walking.Dead")
serier+=("True.Blood")
serier+=("True.Detective")
serier+=("Vikings")

export DISPLAY=:0.0
#echo "Starting"
cd $tempfolder
for file in `ls` ; do
  lowercasefile=${file,,}
  
  for serie in ${serier[@]} ; do
    lowercaseserie=${serie,,}
    echo "Testing ${lowercasefile} and ${lowercaseserie}"
    if [[ $serie != "" && $lowercasefile = *$lowercaseserie* ]] ; then
      [[ ${file} =~ .*([s|S][[:digit:]]+).* ]]
      SEASON=${BASH_REMATCH[1]^^}
      if [[ $SEASON = "" ]] ; then
        [[ ${file} =~ .*([[:digit:]])([[:digit:]])([[:digit:]]).* ]]
        SEASON="S"${BASH_REMATCH[1]^^}
      fi
      if [[ $SEASON != "" ]] ; then
          BASE="${seriemappe}/${serie//./ }"
          DESTINATION="${BASE}/${SEASON}/"
          mkdir -p "${DESTINATION}"
          echo "mv $file \"${DESTINATION}\""
          mv $file "${DESTINATION}"
          SYMLINK="$sisteFiler/$file"
          ln -s "${DESTINATION}$file" $SYMLINK
          echo "ln -s \"${DESTINATION}$file\" $SYMLINK"

          vlc $SYMLINK &
          echo "vlc $SYMLINK &"
      fi
    fi
  done
done

#echo "Done"
exit
