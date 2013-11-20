#!/bin/bash

WD=`pwd`

if [ -z "$1" ]
  then
    MAKEFILE="drupal/make/mysite-cms.make"
  else
    MAKEFILE=$1
fi

drush make --no-gitinfofile --working-copy $MAKEFILE public_html

if [ ! -d "public_html" ]; then
  echo ''
  echo 'Failed to build drupal. Probably a contrib module failed to download.'
  exit 1
fi

cd public_html/sites/default
cp default.settings.php settings.php
mkdir files files/tmp
sudo chown -R vagrant files settings.php

echo "
\$databases = array(
  'default' => array(
    'default' => array(
      'database' => 'mysite_local',
      'username' => 'root',
      'password' => 'root',
      'host' => 'localhost',
      'port' => '',
      'driver' => 'mysql',
      'prefix' => '',
    ),
  ),
);

\$conf['stage_file_proxy_origin'] = 'http://na.mysite.com';
\$conf['securepages_enable'] = FALSE;
\$conf['reroute_email_enable'] = TRUE;
\$conf['cache'] = FALSE; //page cache
\$conf['block_cache'] = FALSE; //block cache
\$conf['preprocess_css'] = FALSE; //optimize css
\$conf['preprocess_js'] = FALSE; //optimize javascript
error_reporting(-1);
\$conf['error_level'] = 2;
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
" >> settings.php

# Install ruby dependencies.
cd $WD
bundle install

# Install composer dependencies.
# composer -d=public_html/profiles/mysite_profile/modules/custom/mymodule install

# Symlink directories to the working directory local profile.
# rm -rf $WD/public_html/profiles/mysite_profile/modules/custom
# ln -nsf $WD/drupal/profiles/mysite_profile/modules/custom $WD/public_html/profiles/mysite_profile/modules/custom
# rm -rf $WD/public_html/profiles/mysite_profile/themes/custom
# ln -nsf $WD/drupal/profiles/mysite_profile/themes/custom $WD/public_html/profiles/mysite_profile/themes/custom

# Compile sass
# bundle exec compass compile $WD/public_html/profiles/mysite_profile/themes/custom/mytheme/