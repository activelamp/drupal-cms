; Drush make file for building Drupal core.

; Drush parameters.
api = "2"
core = "7.x"

; Drupal core.
projects[drupal][type] = "core"
projects[drupal][version] = "7.24"
projects[drupal][download][type] = get
projects[drupal][download][url] = http://ftp.drupal.org/files/projects/drupal-7.24.tar.gz

; Do not alert an ajax error to screen, silently log it.
projects[drupal][patch][] = http://drupal.org/files/core-js-drupal-log-1232416-100-D7.patch

; Support the concept of sub-profiles
projects[drupal][patch][1815700] = http://drupal.org/files/1356276-base_profiles_variable-42.patch

; Array diff assoc recursive function for views cache.
projects[drupal][patch][1850798] = http://drupal.org/files/1850798-base-array_recurse-drupal-47.patch