#WP Setup Environment

A Unix installation tool for quickly setting up a project environment with the latest Word Press and essential plugins.

##Setup
 
1. Create and open a directory with your site name
2. Run ```git clone https://github.com/etidbury/et-wp-template .```
3. Install Word Press and other plugins ```sh install.sh```
4. Start watchers ```sh start.sh```

##What's Included

- Word Press (Latest version)
- Bootstrap + SASS + JS (Latest version)
- Word Press Plugins
    - Custom Fields Pro
    - User Switching

###What happens behind the scenes

- Generates the theme directory
- Downloads the latest Word press directly from https://wordpress.org/latest.zip and unzips
- Adds a generic Grunt configuration to theme directory (.rb)

##Setup Environment

1. Initial setup for a fresh Mac ```xcode-select --install```

2. Install Compass + SASS

    ```sudo gem install -n /usr/local/bin compass```

    ```sudo gem install -n /usr/local/bin sass```


##Miscellaneous 

Live Theme Configuration generator (for LESS):

http://bootstrap-live-customizer.com/
