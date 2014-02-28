#!/bin/bash
tempfolder="/media/raid/temp/"
seriemappe="/media/raid/Serier"
sisteFiler="/media/raid/sisteepisoder"

serier=()
serier+=("Archer")
serier+=("Banshee")
serier+=("Community")
serier+=("Girls")
serier+=("House.of.Lies")
serier+=("Justified")
serier+=("Parks.and.Recreation")
serier+=("Shameless")
serier+=("Suits")
serier+=("The.Americans")
serier+=("The.Big.Bang.Theory")
serier+=("The.Walking.Dead")
serier+=("Vikings")

export DISPLAY=:0.0
echo "Starting"
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

echo "Done"
exit
