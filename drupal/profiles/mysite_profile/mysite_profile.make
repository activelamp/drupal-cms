; Drush make file for the WPP CMS.

; Drush parameters.
api = 2
core = 7.x

; Set sensible defaults.
defaults[projects][subdir] = "contrib"

projects[features][version] = 2.0
projects[features][patch][] = http://drupal.org/files/766264-25-alter-override.patch