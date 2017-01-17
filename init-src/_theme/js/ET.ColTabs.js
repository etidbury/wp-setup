/**
 * @Author Edd Tidbury
 *
 *
 * Usage:
 *
 * 1. Add 'et-col' class to every column to be tabbed along with an id tag
 *
 *      e.g.
 *
 *      <div class="col-sm-6 ... et-col" id="[ID GOES HERE]">...
 *
 *
 * 2. Add Tab Menu wrapper with an ID of 'et-col-menu' and fill with anchor tags
 * with the corresponding links matching the ID's of each column.
 *
 *      e.g.
 *
 *       <ul class="menu tabs" id="et-col-menu">
 *           <li><a href="#et-col-facebook">Facebook</a></li><!--
 *           --><li><a href="#et-col-twitter">Twitter</a></li><!--
 *           --><li><a href="#et-col-instagram">Instagram</a></li>
 *       </ul>
 *
 */
if (!window.ET)
    window.ET={};

window.ET.ColTabs=function(){
    var MAX_MOBILE_WIDTH=767;
    try {
        var self=this;
        if (!jQuery) throw("jQuery was never imported");

        var _$tabCols
            ,_$tabColMenu
            ,_$tabColMenuItems
            ,_tabColRefById=[];

        var toggleTab=function($tabCol){
            _$tabCols.toggleClass('show',false);
            $tabCol.toggleClass('show',true);
        };

        var toggleTabMenuItem=function($tabColMenuItem){
            _$tabColMenuItems.toggleClass('active',false);
            $tabColMenuItem.toggleClass('active',true);
        };


        self.update=function(isMobile) {
            _$tabCols=jQuery('.et-col');

            if (_$tabCols.length<=1) return;//dont activate tabbing if only 1 tab to toggle


            _tabColRefById=function(){
                var m=[];

                _$tabCols.each(function(){
                    var $tabCol=jQuery(this);
                    m["#"+$tabCol.attr('id')]=$tabCol;
                });

                return m;
            }();

            _$tabColMenu=jQuery('#et-col-menu');
            _$tabColMenuItems=jQuery('a[href]',_$tabColMenu);

            if (!_$tabColMenu||!_$tabColMenu[0]) {
                throw("Specify a ETCol Menu (Element #et-col-menu not specified)")
            }

            if (_$tabColMenuItems.length!==_$tabCols.length){
                throw("Number of menu items does not match number of columns");
            }



            if (!isMobile&&jQuery(window).width()<=MAX_MOBILE_WIDTH)
                isMobile=true;



            console.log('tab cols:'+_$tabCols.length,isMobile?"is mobile":"not mobile");

            if (isMobile){
                _$tabColMenu.show();

                toggleTab(jQuery(_$tabCols[0]));

                toggleTabMenuItem(jQuery(_$tabColMenuItems[0]));
            }else {
                _$tabColMenu.hide();
            }


            _$tabCols.unbind('click').bind('click',function(){
                var $tabCol=jQuery(this);
                toggleTab($tabCol);
            });

            _$tabColMenuItems.unbind('click').bind('click',function(e){
                e.preventDefault();
                var $tabColMenuItem=jQuery(this);
                var tabID=$tabColMenuItem.attr('href');
                var $tabCol=_tabColRefById[tabID];


                console.log(_tabColRefById);
                if (!$tabCol||!$tabCol[0])
                    throw("Failed to find column with ID: "+tabID);


                toggleTab($tabCol);
                toggleTabMenuItem($tabColMenuItem);
            });

        };


        jQuery(document).ready(function(){
            self.update();
        });


        return self;
    }catch (err){
        console.trace("ETColTabs: "+err);
    }
}();