
<form name="mutate" method="post" action="index.php" enctype="multipart/form-data">
    <input type="hidden" name="id" value="26">
    <input type="hidden" name="a" value="302">
    <input type="hidden" name="or" value="76">
    <input type="hidden" name="oid" value="">
    <input type="hidden" name="mode" value="301">
    <input type="hidden" name="params" value="">

    <h1 class="pagetitle">
      <span class="pagetitle-icon">
        <i class="fa fa-list-alt"></i>
      </span>
        <span class="pagetitle-text">
        Создать / редактировать <параметр></параметр>      </span>
    </h1>

    <div id="actions">
        <ul class="actionButtons">
            <li id="Button1" class="transition">
                <a href="#" onclick="documentDirty=false; form_save=true; document.mutate.save.click();saveWait('mutate');">
                    <img src="media/style/MODxRE2/images/icons/save.png"> Сохранить                </a>
                <span class="plus"> + </span>
                <select id="stay" name="stay">
                    <option id="stay1" value="1">Создать новый</option>
                    <option id="stay2" value="2">Продолжить</option>
                    <option id="stay3" value="" selected="selected">Закрыть</option>
                </select>
            </li>
            <li id="Button6"><a href="#" onclick="duplicaterecord();"><img src="media/style/MODxRE2/images/icons/clone.png"> Сделать копию</a></li>
            <li id="Button3"><a href="#" onclick="deletedocument();"><img src="media/style/MODxRE2/images/icons/trash.png"> Удалить</a></li>
            <li id="Button5" class="transition"><a href="#" onclick="documentDirty=false;document.location.href='index.php?a=76';"><img src="media/style/MODxRE2/images/icons/cancel.png"> Отмена</a></li>
        </ul>
    </div>

    <script type="text/javascript" src="media/script/tabpane.js"></script>
    <div class="sectionBody">
        <div class="dynamic-tab-pane-control tab-pane" id="tmplvarsPane"><div class="tab-row"><h2 class="tab selected"><span>Общие</span></h2></div>
            <script type="text/javascript">
                tpTmplvars = new WebFXTabPane( document.getElementById( "tmplvarsPane" ), false );
            </script>
            <div class="tab-page" id="tabGeneral" style="display: block;">

                <script type="text/javascript">tpTmplvars.addTabPage( document.getElementById( "tabGeneral" ) );</script>

                <p class="element-edit-message">
                    Здесь вы можете создать / отредактировать параметр (TV). <br> Помните, параметры должны быть доступны для выбранных шаблонов, чтобы их можно было использовать. <br><br>     </p>

                <table>
                    <tbody><tr>
                        <th>Имя параметра</th>
                        <td>[*&nbsp;<input name="name" type="text" maxlength="50" value="content_en" class="inputBox" style="width:250px;" onchange="documentDirty=true;">*]&nbsp; <span class="warning" id="savingMessage">&nbsp;</span></td>
                    </tr>
                    <tr>
                        <th>Заголовок</th>
                        <td><input name="caption" type="text" maxlength="80" value="Содержимое ресурса" class="inputBox" style="width:300px;" onchange="documentDirty=true;">
                            <script>document.getElementsByName("caption")[0].focus();</script></td>
                    </tr>

                    <tr>
                        <th>Описание</th>
                        <td><input name="description" type="text" maxlength="255" value="" class="inputBox" style="width:300px;" onchange="documentDirty=true;"></td>
                    </tr>
                    <tr>
                        <th>Существующие категории</th>
                        <td><select name="categoryid" style="width:300px;" onchange="documentDirty=true;">
                                <option>&nbsp;</option>
                                <option value="7">add</option><option value="12">BLang</option><option value="8">Content</option><option value="13" selected="selected">en</option><option value="2">Forms</option><option value="3">Js</option><option value="11">lang</option><option value="9">Manager</option><option value="5">Manager and Admin</option><option value="6">Navigation</option><option value="1">SEO</option><option value="10">system</option><option value="4">Templates</option><option value="14">ua</option>        </select>
                        </td>
                    </tr>
                    <tr>
                        <th>Новая категория</th>
                        <td><input name="newcategory" type="text" maxlength="45" value="" class="inputBox" style="width:300px;" onchange="documentDirty=true;"></td>
                    </tr>
                    <tr>
                        <th colspan="2"><label><input name="locked" value="on" type="checkbox" class="inputBox"> Ограничить доступ к редактированию параметра</label> <span class="comment">Только администраторы (ID роли - 1) могут редактировать этот параметр.</span></th>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <th>Тип ввода</th>
                        <td><select name="type" size="1" class="inputBox" style="width:300px;" onchange="documentDirty=true;">
                                <optgroup label="Standard Type">
                                    <option value="text">Text</option>

                                    <option value="textarea">Textarea</option>

                                    <option value="textareamini">Textarea (Mini)</option>
                                    <option value="richtext" selected="selected">RichText</option>
                                    <option value="dropdown">DropDown List Menu</option>
                                    <option value="listbox">Listbox (Single-Select)</option>
                                    <option value="listbox-multiple">Listbox (Multi-Select)</option>
                                    <option value="option">Radio Options</option>
                                    <option value="checkbox">Check Box</option>
                                    <option value="image">Image</option>
                                    <option value="file">File</option>
                                    <option value="url">URL</option>
                                    <option value="email">Email</option>
                                    <option value="number">Number</option>
                                    <option value="date">Date</option>
                                </optgroup>
                                <optgroup label="Custom Type">
                                    <option value="custom_tv">Custom Input</option>
                                    <option value="custom_tv:multitv">multitv</option>               </optgroup>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>Возможные значения</th>
                        <td nowrap="nowrap"><textarea name="elements" maxlength="65535" class="inputBox textarea" onchange="documentDirty=true;"></textarea><img src="media/style/MODxRE2/images/icons/question-sign.png" onmouseover="this.src='media/style/MODxRE2/images/icons/question-sign-trans.png';" onmouseout="this.src='media/style/MODxRE2/images/icons/question-sign.png';" alt="Это поле поддерживает привязку данных с использованием @-команд" onclick="alert(this.alt);" style="cursor:help"></td>
                    </tr>
                    <tr>
                        <th>Значение по умолчанию</th>
                        <td nowrap="nowrap"><textarea name="default_text" type="text" class="inputBox" rows="5" style="width:300px;" onchange="documentDirty=true;"></textarea><img src="media/style/MODxRE2/images/icons/question-sign.png" onmouseover="this.src='media/style/MODxRE2/images/icons/question-sign-trans.png';" onmouseout="this.src='media/style/MODxRE2/images/icons/question-sign.png';" alt="Это поле поддерживает привязку данных с использованием @-команд" onclick="alert(this.alt);" style="cursor:help"></td>
                    </tr>
                    <tr>
                        <th>Визуальный компонент</th>
                        <td>
                            <select name="display" size="1" class="inputBox" style="width:300px;" onchange="documentDirty=true;showParameters(this);">
                                <option value="" selected="selected">&nbsp;</option>
                                <optgroup label="Widgets">
                                    <option value="datagrid">Data Grid</option>
                                    <option value="richtext">RichText</option>
                                    <option value="viewport">View Port</option>
                                    <option value="custom_widget">Custom Widget</option>
                                </optgroup>
                                <optgroup label="Formats">
                                    <option value="htmlentities">HTML Entities</option>
                                    <option value="date">Date Formatter</option>
                                    <option value="unixtime">Unixtime</option>
                                    <option value="delim">Delimited List</option>
                                    <option value="htmltag">HTML Generic Tag</option>
                                    <option value="hyperlink">Hyperlink</option>
                                    <option value="image">Image</option>
                                    <option value="string">String Formatter</option>
                                </optgroup>
                            </select>
                        </td>
                    </tr>
                    <tr id="displayparamrow" style="display: none;">
                        <th>Свойства компонента (widget)<div style="padding-top:8px;"><a href="javascript://" onclick="resetParameters(); return false"><img src="media/style/MODxRE2/images/icons/refresh.png" alt="Сбросить параметры"></a></div></th>
                        <td id="displayparams">&nbsp;</td>
                    </tr>
                    <tr>
                        <th>Порядок в списке</th>
                        <td><input name="rank" type="text" maxlength="4" value="0" class="inputBox" style="width:300px;" onchange="documentDirty=true;"></td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    </tbody></table>
                <div class="sectionHeader">Доступ шаблонов</div>
                <div class="sectionBody">
                    <p>Укажите шаблоны, которые могут использовать этот Параметр (TV)</p>
                    <ul class="actionButtons">
                        <li><a href="#" onclick="check_all();return false;">Включить все</a></li>
                        <li><a href="#" onclick="check_none();return false;">Выключить все</a></li>
                        <li><a href="#" onclick="check_toggle(); return false;">Переключить</a></li>
                    </ul>
                    <style type="text/css">
                        label {display:block;}
                    </style>
                    <table>
                        <tbody><tr>
                            <td>
                                <ul><li><strong>Без категории</strong><ul><li><label><input name="template[]" value="3" type="checkbox" onchange="documentDirty=true;">Главная&nbsp;<small>(3)</small></label></li><li><label><input name="template[]" value="6" type="checkbox" onchange="documentDirty=true;">Заказ&nbsp;<small>(6)</small></label></li><li><label><input name="template[]" value="5" type="checkbox" onchange="documentDirty=true;">Каталог&nbsp;<small>(5)</small></label></li><li><label><input name="template[]" value="4" type="checkbox" checked="checked" onchange="documentDirty=true;">Товар&nbsp;<small>(4)</small> <em>(Шаблон по умолчанию:)</em></label></li></ul></li></ul>    </td>
                        </tr>
                        </tbody></table>
                </div>
                <!-- Access Permissions -->
                <div class="sectionHeader">Права доступа</div><div class="sectionBody">
                    <script type="text/javascript">
                        function makePublic(b){
                            var notPublic=false;
                            var f=document.forms['mutate'];
                            var chkpub = f['chkalldocs'];
                            var chks = f['docgroups[]'];
                            if(!chks && chkpub) {
                                chkpub.checked=true;
                                return false;
                            }
                            else if (!b && chkpub) {
                                if(!chks.length) notPublic=chks.checked;
                                else for(i=0;i<chks.length;i++) if(chks[i].checked) notPublic=true;
                                chkpub.checked=!notPublic;
                            }
                            else {
                                if(!chks.length) chks.checked = (b)? false:chks.checked;
                                else for(i=0;i<chks.length;i++) if (b) chks[i].checked=false;
                                chkpub.checked=true;
                            }
                        }
                    </script>
                    <p>Выберите группы ресурсов, в которых разрешена смена этого Дополнительного Параметра (TV)</p>
                    <label><input type="checkbox" name="chkalldocs" checked="checked" onclick="makePublic(true)"><span class="warning">Без группы (доступен для всех)</span></label>	</div>

            </div>


            <input type="submit" name="save" style="display:none">

            <!-- Begin ManagerManager output -->
            <script type="text/javascript">
                var $j = jQuery.noConflict();

                $j("select[name=type] option").each(function(){
                    var $this = $j(this);
                    if(!($this.text().match("deprecated") == null)){
                        $this.remove();
                    }
                });
            </script>
            <!-- End ManagerManager output --></div>
    </div>
</form>