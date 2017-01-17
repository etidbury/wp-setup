<?php

function js_include()
{
    wp_enqueue_script('pace.js', get_template_directory_uri() . "/js/pace.js", array('jquery'), '1.0');
    wp_enqueue_script('modernizr.js', get_template_directory_uri() . "/js/modernizr.js", array('jquery'), '2.7.1');
    wp_enqueue_script('transit.min.js', get_template_directory_uri() . "/js/transit.min.js", array('jquery'), '1.0');

    wp_enqueue_script('main.js', get_template_directory_uri() . "/js/main.js", array('jquery'), '0.1');

    wp_enqueue_script('bootstrap.min.js', get_template_directory_uri() . "/js/bootstrap.min.js", array('jquery'), '0.1');
    wp_enqueue_script('ET.ColTabs.js', get_template_directory_uri() . "/js/ET.ColTabs.js", array('jquery'), '0.1');
}

add_action( 'wp_enqueue_scripts', 'js_include');