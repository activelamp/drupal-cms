<?php

/**
 * @file
 * An installation file for MySite Core
 */

/**
 * Task handler to load our install profile and enhance the dependency information
 */
function mysite_core_install_load_profile(&$install_state) {
  // Include any dependencies that we might have missed...
  require_once(drupal_get_path('module', 'panopoly_core') . '/panopoly_core.profile.inc');
  panopoly_core_install_load_profile($install_state);
}
