<?php
show_admin_bar(false);


//ROLES
add_action('after_switch_theme', 'remove_other_roles');
function remove_other_roles()
{
    if (get_role('subscriber')) {
        remove_role('editor');
        remove_role('contributor');
        remove_role('subscriber');
    }
}

add_action('after_switch_theme', 'create_role');

function create_role()
{
    add_role(
        'super_author',
        __('Super Author'),
        array(
            'read' => true,  // true allows this capability
            'delete_posts' => true,
            'delete_published_posts' => true,
            'edit_posts' => true,
            'edit_published_posts' => true,
            'publish_posts' => true,
            'upload_files' => true,
            'create_users' => true,
            'list_users' => true,
            'edit_users' => true,
            'delete_users' => true
        )
    );
}

add_action('switch_theme', 'remove_custom_role');
function remove_custom_role()
{
    remove_role('super_author');
}

function wpse_188863_get_allowed_roles($user)
{
    $allowed = array();

    if (in_array('administrator', $user->roles)) { // Admin can edit all roles
        $allowed = array_keys($GLOBALS['wp_roles']->roles);
    } elseif (in_array('super_author', $user->roles)) {
        $allowed[] = 'author';
    }

    return $allowed;
}

function wpse_188863_editable_roles($roles)
{
    if ($user = wp_get_current_user()) {
        $allowed = wpse_188863_get_allowed_roles($user);

        foreach ($roles as $role => $caps) {
            if (!in_array($role, $allowed))
                unset($roles[$role]);
        }
    }

    return $roles;
}

add_filter('editable_roles', 'wpse_188863_editable_roles');

function wpse_188863_map_meta_cap($caps, $cap, $user_ID, $args)
{
    if (($cap === 'edit_user' || $cap === 'delete_user') && $args) {
        $the_user = get_userdata($user_ID); // The user performing the task
        $user = get_userdata($args[0]); // The user being edited/deleted

        if ($the_user && $user && $the_user->ID != $user->ID /* User can always edit self */) {
            $allowed = wpse_188863_get_allowed_roles($the_user);

            if (array_diff($user->roles, $allowed)) {
                // Target user has roles outside of our limits
                $caps[] = 'not_allowed';
            }
        }
    }

    return $caps;
}

add_filter('map_meta_cap', 'wpse_188863_map_meta_cap', 10, 4);


add_action('load-edit.php', 'posts_for_current_contributor');

function posts_for_current_contributor()
{
    global $user_ID;


    if (!isset($_GET['author'])) {
        wp_redirect(add_query_arg('author', $user_ID));
        exit;
    }

}


// add_action( 'load-edit.php', 'wpse14230_load_edit' );
// function wpse14230_load_edit()
// {
//     add_action( 'request', 'wpse14230_request' );
// }

// function wpse14230_request( $query_vars )
// {
//     if ( ! current_user_can( $GLOBALS['post_type_object']->cap->edit_others_posts ) ) {
//         $query_vars['author'] = get_current_user_id();
//     }
//     return $query_vars;
// }

// Get the page number
function get_page_number()
{
    if (get_query_var('paged')) {
        print ' | ' . __('Page ', 'hbd-theme') . get_query_var('paged');
    }
} // end get_page_number

add_theme_support('menus');
add_theme_support('post-thumbnails');


require('js-inc.functions.php');


// HIDE ADMIN MENUS
function remove_menus()
{
    $current_user = wp_get_current_user();
    if (!$current_user->caps['administrator']):

        remove_menu_page('edit-comments.php');
        remove_menu_page('upload.php');
        remove_menu_page('edit.php?post_type=page');
        remove_menu_page('edit.php?post_type=acf-field-group');
        remove_menu_page('themes.php');
        remove_menu_page('plugins.php');
        remove_menu_page('tools.php');

    endif;
}

add_action('admin_menu', 'remove_menus');

function hide_editor()
{
    remove_post_type_support('post', 'editor');
    remove_post_type_support('post', 'post-formats');
}

add_action('init', 'hide_editor');


require('rename.functions.php');


require('acf.functions.php');

