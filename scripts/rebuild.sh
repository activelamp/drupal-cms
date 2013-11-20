#!/bin/bash

# This script will rebuild the profile make file locally. It will remove and
# redownload all projects specified in profile make file.
#
# This script does the following:
#
#   1. Removes all projects in modules/contrib, themes/contrib, and libraries
#      paths in profiles.
#   2. Runs the profile make files and redownloads files to the directories
#      that were just deleted.
#
# **Beware:** that this script deletes the directories it rebuilds.

profile_dir="profiles/mysite_profile"
file="drupal/"$profile_dir"/mysite_profile.make"

# Pull down the new code
# Remove the directories we are rebuilding
echo "Deleting rebuilt directories in" `pwd`
rm -rf public_html/$profile_dir/modules/contrib public_html/$profile_dir/themes/contrib public_html/$profile_dir/libraries

# Re-download everything.
echo "Rebuilding profile..." $file
drush make --yes --no-core --working-copy --contrib-destination=public_html/$profile_dir $file

# Add any special composer tasks here
# composer -d=public_html/profiles/mysite_profile/modules/custom/mymodule install