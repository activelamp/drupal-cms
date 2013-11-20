; Drush make file for profile based CMS.

; Drush parameters.
api = 2
core = 7.x

; Include other make files.
includes[drupal_core] = "drupal-core.make"

; Copy a custom site profile from a local directory.
;projects[mysite_profile][type] = profile
;projects[mysite_profile][download][type] = local
;projects[mysite_profile][download][source] = "drupal/profiles/mysite_profile"
;projects[mysite_profile][version] = 7.x-1.x

; Download a base profile to extend
projects[panopoly][type] = profile
projects[panopoly][version] = 1.0-rc5