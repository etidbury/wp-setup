<?php

// acf_add_options_page(array(
// 	'page_title' => 'Password Page',
// 	'position' => '57.2',
// 	'icon_url' => 'dashicons-lock'
// ));

// RENAME "POSTS"

function revcon_change_post_label() {
    global $menu;
    global $submenu;
    $menu[5][0] = 'Artists';
    $submenu['edit.php'][5][0] = 'Artists';
    $submenu['edit.php'][10][0] = 'Add Artist';
    $submenu['edit.php'][16][0] = 'Artist Tags';
}

function revcon_change_post_object() {
    global $wp_post_types;
    $labels = &$wp_post_types['post']->labels;
    $labels->name = 'Artists';
    $labels->singular_name = 'Artist';
    $labels->add_new = 'Add Artist';
    $labels->add_new_item = 'Add Artist';
    $labels->edit_item = 'Edit Artist';
    $labels->new_item = 'Artist';
    $labels->view_item = 'View Artist';
    $labels->search_items = 'Search Artists';
    $labels->not_found = 'No Artist found';
    $labels->not_found_in_trash = 'No Artists found in Trash';
    $labels->all_items = 'All Artists';
    $labels->menu_name = 'Artists';
    $labels->name_admin_bar = 'Artists';
}

add_action( 'admin_menu', 'revcon_change_post_label' );
add_action( 'init', 'revcon_change_post_object' );
// END RENAME "POSTS"

//REMOVE TAGS/CATEGORIES
// Remove tags support from posts
function myprefix_unregister_tags() {
    unregister_taxonomy_for_object_type('post_tag', 'post');
    unregister_taxonomy_for_object_type('category', 'post');
}
add_action('init', 'myprefix_unregister_tags');