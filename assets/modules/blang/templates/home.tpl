<script>
    function initQuicksearch(inputId, listId) {
        jQuery('#'+inputId).quicksearch('#'+listId+' ul li', {
            selector: 'a',
            'show': function () { jQuery(this).removeClass('hide'); },
            'hide': function () { jQuery(this).addClass('hide'); },
            'bind':'keyup',
            'onAfter': function() {
                jQuery('#'+listId).find('> li > ul').each( function() {
                    var parentLI = jQuery(this).closest('li');
                    var totalLI  = jQuery(this).children('li').length;
                    var hiddenLI = jQuery(this).children('li.hide').length;
                    if (hiddenLI == totalLI) { parentLI.addClass('hide'); }
                    else { parentLI.removeClass('hide'); }
                });
            }
        });
    }
    function saveSetting() {
        jQuery('#settings-form').submit();
    }
    function removeLang() {

            if(confirm("Вы уверены, что хотите удалить?")==true) {
                jQuery('#removeLanguageForm').submit();
            }

    }

</script>


<h1 class="pagetitle">
  <span class="pagetitle-icon">
    <i class="fa fa-file-text"></i>
  </span>
    <span class="pagetitle-text">
  [+_blang_title+]
  </span>
</h1>
<div class="sectionBody">
    <div class="tab-pane" id="bLangPanel">
        <script type="text/javascript">
            tpResources = new WebFXTabPane(document.getElementById('bLangPanel'));
        </script>

        <div class="tab-page" id="tabWok">
            <h2 class="tab"><i class="fa fa-newspaper-o"></i> [+_wok+]</h2>
            <div id="container"></div>
            <div class="actionButtons">
            <a type='button'  onclick=' $$("data").add({id:"-"})' class='primary'>[+_add_row+]</a>
            </div>

        </div>
        <div class="tab-page" id="tabTemplates">
            <h2 class="tab"><i class="fa fa-list-alt"></i> [+_tab_params+]</h2>
            <ul class="actionButtons">
                <li>
                    <form class="filterElements-form">
                        <input class="form-control" type="text" placeholder="[+_element_filter_msg+]" id="site_tmplvars_search">
                    </form>
                </li>
                <li><a href="[+moduleurl+]action=param">[+_new_tmplvars+]</a></li>

                <li><a href="[+moduleurl+]action=paramSort">[+_sort+]</a></li>
                <li><a href="[+moduleurl+]action=paramDefault" >[+_paramDefault+]</a></li>
                <li><a href="[+moduleurl+]action=updateTV" >[+_update+]</a></li>
            </ul>
            [+tvLst+]



            <script>
                initQuicksearch('site_tmplvars_search', 'blang_tmplvars');
        </script>

        </div>
        <div class="tab-page" id="tabSync">
            <h2 class="tab"><i class="fa fa-newspaper-o"></i> [+_tab_settings+]</h2>

            <div id="actions">
            <ul class="actionButtons">
                <li id="Button1" class="transition">
                    <a href="#" onclick="documentDirty=false; form_save=true; saveSetting();">
                        <img src="media/style/MODxRE2/images/icons/save.png"> [+_settings_save+]
                    </a>
                </li>
            </ul>
            </div>

            <form action="[+moduleurl+]action=settings-save" id="settings-form" method="post">
                <table>

                    <tr>
                        <th>[+_settings_langs+]</th>
                        <td>
                            <input name="langs" type="text"  value="[+setting_langs+]" class="inputBox" style="width:300px;" onchange="documentDirty=true;">
                        </td>
                    </tr>
                    <tr>
                        <th>[+_settings_root+]</th>
                        <td>
                            <input name="root" type="text"  value="[+setting_root+]" class="inputBox" style="width:300px;" onchange="documentDirty=true;">
                        </td>
                    </tr>

                    <tr>
                        <th>[+_settings_fields+]</th>
                        <td>
                            <input name="fields" type="text"  value="[+setting_fields+]" class="inputBox" style="width:300px;" onchange="documentDirty=true;">
                        </td>
                    </tr>

                    <tr>
                        <th>[+_settings_translate+]</th>
                        <td>
                            <input name="translate" type="text"  value="[+setting_translate+]" class="inputBox" style="width:300px;" onchange="documentDirty=true;">
                        </td>
                    </tr>

                    <tr>
                        <th>[+_settings_yandexKey+]</th>
                        <td>
                            <input name="yandexKey" type="text"  value="[+setting_yandexKey+]" class="inputBox" style="width:300px;" onchange="documentDirty=true;">
                        </td>
                    </tr>





                </table>
            </form>

        </div>
        <div class="tab-page" id="tabRemove">
            <h2 class="tab"><i class="fa fa-newspaper-o"></i> [+_removeLang+]</h2>
            
            <form method="post" action="[+moduleurl+]action=removeLanguage" id="removeLanguageForm">
                <table>
                    <tr style="height: 24px;/* display: none; */"><td><span class="warning">[+_lang_caption+]</span></td>
                        <td>
                            <select  name="lang" class="inputBox" >
                                <option value="0">--------------</option>
                                [+languages_options+]
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td>
                            <ul class="actionButtons">
                                <li>
                                    <a   href="#" class="primary btn-submit" onclick="removeLang()">[+_remove+]</a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                </table>

            </form>

        </div>



    </div>
</div>


<script>

    function add_row() {
        var values = $$("form_add").getValues();
        $.post('[+moduleurl+]action=save', values, function () {
            $$("data").loadNext(-1, 0);
            $$('form_add').clear();
        })
    }

    function removeData(id) {
        webix.confirm({
            title: "Удалить",// the text of the box header
            text: "Вы уверенны что хотите удалить?",
            callback: function (result) {
                if (result) {
                    $$("data").remove(id);
                }
            }
        });

    }

    function my_translate(id) {
        var dataTable = $$("data");

        var record = dataTable.getItem(id);


        var status = false;

        for(key in record){
            if(key === 'id' || key === 'name' || key === 'title') { continue; }

            if(typeof record[key] !=='undefined' && record[key] !=='' ){
                status = true;
            }
        }
        if(status === false){
            webix.message({type:"error", text:"[+_noLangSet+]"});
            return false;
        }
        $.post('[+moduleurl+]action=translate', record, function (elem) {
            for(key in elem){
                record[key] = elem[key];
            }
            dataTable.updateItem(id, record);
        })
    }


    webix.ui({
            container: "container",
            cols: [
                {
                    rows: [{
                        view: "datatable",
                        id: "data",
                        columns: [

                            { id: "id", editor: "text", name: "id", header: "id"},
                            { id: "name", editor: "text", name: "name", header: "[+_header_name+]"},
                            { id: "title", editor: "text", name: "title", header: "[+_header_tyltip+]"},

                            [+lang_columns+]
                            {

                                header: ["<center><a style='margin-top:10px ' class='deleteButton btnSmall webix_icon fa-close'></a></center>"],
                                template: "<center><a class='deleteButton btnSmall webix_icon fa-close' onclick='removeData(#id#)'></a></center>",
                                width: 50
                            },
                            {

                                header: ["<a class='webix_icon fa-globe'></a>"],
                                template: "<a class='webix_icon fa-globe' onclick='my_translate(#id#)'></a>",
                                width: 50
                            }

                        ],
                        editable: true,
                        autoheight: true,

                        url: "[+moduleurl+]action=getData",
                        save: "[+moduleurl+]action=save"
                    }

                    ]
                }

            ]
        }
    );
</script>