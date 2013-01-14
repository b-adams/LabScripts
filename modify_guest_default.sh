#! /bin/bash
#Scripting info: http://www.noendpress.com/vroman/shellscripting/index.php
#Script tasks: http://www.michaelsmac.com/modules.php?name=News&file=article&sid=394
#Dealing with spaces: http://www.davidpashley.com/articles/writing-robust-shell-scripts.html

#Make sure we have needed permissions
if [ $UID = 0 ]; then
    echo You have appropriate permissions.
    echo ""
else
    echo You must \'su custodian\' and then \'sudo -s\' first
    echo ""
    exit 0
fi

SOURCE="/Users/Guest/"
TARGET="/System/Library/User Template/English.lproj/"
BACKUP="/System/Library/UserTemplateBackup.$(date +%y%m%d).tgz"
BACKDIR="/System/Library/User Template"
SASDIR="/System/Library/User Template/English.lproj/Library/Saved Application State/"

# Just in case, let's make a backup of the User Template before we change anything. (Restore instructions are at the end of this article.)

echo Backing up template to "$BACKUP$" \(this will take some time\)...
echo tar cfz \"$BACKUP\" \"$BACKDIR\"
tar cfz "$BACKUP" "$BACKDIR"
#tar cfz UserTemplateBackup.$thedate.tar.gz \"User Template\"
echo ""

# You are now ready to copy the new Guest folders to the template location. Did you change any Finder window settings, such as icon size or grid? Then we need to copy the hidden .DS_Store file. In the terminal type after the prompt:

echo cp \"$SOURCE.DS_Store\" \"$TARGET.DS_Store\"
cp "$SOURCE.DS_Store" "$TARGET.DS_Store"
echo ""

echo cp \"$SOURCEscripts" \"$TARGETscripts"
cp "$SOURCEscripts" "$TARGETscripts"
echo ""


# If you added a custom desktop picture to the Pictures folder we will need to copy that folder. The first terminal command deletes the original Pictures template folder. The second line copies the new folder from the Guest user.

curdir=Pictures/
echo Applying fixative to "$curdir" folder...
echo rm -R \"$TARGET$curdir\"
echo cp -R \"$SOURCE$curdir\" \"$TARGET$curdir\"
rm -R "$TARGET$curdir"
cp -R "$SOURCE$curdir" "$TARGET$curdir"
echo ""



# All the other changes you made: the Dock, System Preferences, etc, are in the Library folder. That gets copied to the User Template folder with the following two commands. (Similar to Pictures, first we delete the template and then copy the new one.)

curdir=Library/
echo Applying fixative to "$curdir" folder...
echo rm -R \"$TARGET$curdir\"
echo cp -R \"$SOURCE$curdir\" \"$TARGET$curdir\"
rm -R "$TARGET$curdir"
cp -R "$SOURCE$curdir" "$TARGET$curdir"
echo ""

echo Removing saved application state
echo rm -R \"$SASDIR\"
rm -R "$SASDIR"
echo ""

# Unless you added files to the other Guest home folders, for example: Documents, Music, Public, etc, you're done! Otherwise, adapt the two terminal lines above to delete the originals and copy the replacements.

curdir=Shortcuts/
echo Applying fixative to "$curdir" folder...
echo rm -R \"$TARGET$curdir\"
echo cp -R \"$SOURCE$curdir\" \"$TARGET$curdir\"
rm -R "$TARGET$curdir"
cp -R "$SOURCE$curdir" "$TARGET$curdir"
echo ""

#Also save Dropbox settings
#http://www.dropbox.com/help/41

curdir=.dropbox/
echo Applying fixative to "$curdir" folder...
echo rm -R \"$TARGET$curdir\"
echo cp -R \"$SOURCE$curdir\" \"$TARGET$curdir\"
rm -R "$TARGET$curdir"
cp -R "$SOURCE$curdir" "$TARGET$curdir"
echo ""

echo ALL DONE!

exit 1
