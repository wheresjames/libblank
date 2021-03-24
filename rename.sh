#!/bin/bash

#--------------------------------------------------------------------------------------------------
USAGE="USAGE: ${BASH_SOURCE[0]} <new-lib-name> <new-namespace>"

#--------------------------------------------------------------------------------------------------
SCRIPTPATH=$(realpath ${BASH_SOURCE[0]})
ROOTDIR=$(dirname $SCRIPTPATH)
if [[ ! -d "$ROOTDIR" ]]; then
    echo "Invalid script path: ${ROOTDIR}"
    exit -1
fi
. "${ROOTDIR}/prv/sh/rbashutils.sh"

#--------------------------------------------------------------------------------------------------
NEWNAME=$1
NEWNS=$2
if [[ -z $NEWNAME ]] || [[ -z $NEWNS ]]; then
    exitWithError "$USAGE"
fi

if [[ "$NEWNAME" =~ [^a-zA-Z0-9\-] ]]; then
    exitWithError "Name may only contain characters [a-z A-Z 0-9 -] : $NEWNAME"
fi

if [[ "$NEWNS" =~ [^a-zA-Z0-9\-] ]]; then
    exitWithError "Namespace may only contain characters [a-z A-Z 0-9 -] : $NEWNS"
fi

#--------------------------------------------------------------------------------------------------
SRCPATH="$ROOTDIR"
TGTPATH="../${NEWNAME}"
if [ -d "$TGTPATH" ]; then
    exitWithError "Already exists : $TGTPATH"
fi


#--------------------------------------------------------------------------------------------------
copyFiles()
{
    local IND=$1
    local OUTD=$2

    if [ ! -d "$OUTD" ]; then
        showInfo "${OUTD}"
        mkdir -p "$OUTD"
        exitOnError "Failed to create directory : ${OUTD}"
    fi

    local FILES=$IND/*

    for SRC in $FILES
    do

        local FNAME=`basename $SRC`
        local TGT=$OUTD/$FNAME
        local TGTEX=${TGT//libblank/${NEWNAME}}

        # Directory
        if [ -d $SRC ]; then
            copyFiles $SRC $TGTEX

        # Empty directory
        elif [[ $SRC =~ "*" ]]; then
            showWarning "Empty directory: ${TGTEX}"

        # File
        else
            showInfo "Copy $SRC -> $TGTEX"

            cp "$SRC" "$TGTEX"

            # Project name
            sed -i "s/libblank/${NEWNAME}/g" "$TGTEX"
            sed -i "s/LIBBLANK/${NEWNAME^^}/g" "$TGTEX"

            # Library name
            sed -i "s/lblank/l${NEWNAME//lib/}/g" "$TGTEX"

            # Namespace
            sed -i "s/lbk/${NEWNS}/g" "$TGTEX"

        fi

    done

}

#--------------------------------------------------------------------------------------------------

copyFiles "$SRCPATH" "$TGTPATH"

# Use template readme
if [ -f "$TGTPATH/README.md.tmpl" ]; then
    rm "$TGTPATH/README.md"
    mv "$TGTPATH/README.md.tmpl" "$TGTPATH/README.md"
fi

# Who knows what might happen if this is run again
rm "$TGTPATH/rename.sh"

echo
echo "Project $NEWNAME has been created in $TGTPATH"
echo "To get started, go to your new project directory and type"
echo "conan install . && conan build . && ./run.sh help"
echo
