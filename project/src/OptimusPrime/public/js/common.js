//////////////////////////////////////////////////////////////////////////

String.prototype.parseJSONDate = function () {
    return eval(this.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"));
};

//////////////////////////////////////////////////////////////////////////
/*
*	tree 
*/
function removePriviousDomId(dialogID) {
    if ($("#" + dialogID).length > 0) {
        $("#" + dialogID).remove();
    }
}

function getChecked(treeId, keyAttr) {
    var nodes = $('#' + treeId).tree('getChecked');
    var result = new Array();
    var count = 0;
    for (var i = 0; i < nodes.length; i++) {
        if (undefined == keyAttr || undefined != nodes[i].attributes[keyAttr]) {
            result[count++] = nodes[i];
        }
    }
    return result;
}

function getSelected(treeId) {
    return $('#' + treeId).tree('getSelected');
}
function collapse(treeId) {
    var node = $('#' + treeId).tree('getSelected');
    $('#' + treeId).tree('collapse', node.target);
}
function expand(treeId) {
    var node = $('#' + treeId).tree('getSelected');
    $('#' + treeId).tree('expand', node.target);
}
function collapseAll(treeId) {
    var node = $('#' + treeId).tree('getSelected');
    if (node) {
        $('#' + treeId).tree('collapseAll', node.target);
    } else {
        $('#' + treeId).tree('collapseAll');
    }
}
function expandAll(treeId) {
    var node = $('#' + treeId).tree('getSelected');
    if (node) {
        $('#' + treeId).tree('expandAll', node.target);
    } else {
        $('#' + treeId).tree('expandAll');
    }
}
function isLeaf(treeId, node) {
    return $('#' + treeId).tree('isLeaf', node.target);
}



//////////////////////////////////////////////////////////////////////////
//edit datagrid
//////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
//是否有修改数据
/////////////////////////////////////////////////////////////////////////////
function getChanges(grid) {
    if (grid) {
        if (grid.datagrid('getChanges').length > 0 || currProcessingIndex != -1) {
            return true
        }
        return false;
    }
    else {
        alert("grid object is null");
    }
}

function backLevel(grid, backUrl) {
    if (grid) {
        if (grid.datagrid('getChanges').length > 0 || currProcessingIndex != -1) {
            $.messager.confirm("删除", "确实要放弃所作的修改吗？", function (r) {
                if (r) {
                    updateContent(backUrl);
                }
            });
        } else {
            updateContent(backUrl);
        }
    }
    else {
        alert("grid object is null");
    }
}

function AddToolTip4GridField(grid, fieldName) {
    var fields = $(grid).parent().find("td[field='" + fieldName + "']>div");
    $.each(fields, function (i, n) {
        if (i == 0) { return; }
        $(this).qtip({
            content: "" + $(this).text(),
            position: {
                target: 'mouse',
                //corner: { target: 'topRight', tooltip: 'bottomLeft' },
                corner: { target: 'bottomMiddle', tooltip: 'topMiddle' },
                // corner:　{target:'mouse'},
                adjust: { mouse: true, scroll: true }
            },
            show: { solo: true },
            hide: { delay: 800 },
            style: {
                border: { radius: 0, width: 1 },
                //padding: '5px　15px', //　Give　it　some　extra　padding　
                tip: true,
                name: 'blue'//　And　style　it　with　the　preset　dark　theme　
            }
        });
    });
}
/**************************************
* 此函数用于对datagrid进行初始化
* grid：  要初始化的grid,jquery变量
* processChangeUrl: 对表格数据进行增加，删除，修改的服务端处理url
* createInitOption: 在增加记录的时候，用于增加对隐含/额外未列出的字段的初始化选项
* backurl:如果需要返回按钮时，这个表示返回按钮要回到的页面url
* buttonMask: 表格工具栏上按钮，依次是：新建，编辑，删除，保存，每个用一位表示。如果此值为10，将只显示编辑和保存按钮；
*             如果为0，将工具栏不显示上面4个按钮，如果缺省或者其他将4个按钮都显示。
* onBeforeSave：在保存之前，会回调此函数进行您想要的约束性检查，其参数依次是：grid, rowdata, index.
* needToolTipFields: 在鼠标放在该记录上面，显示tooltip的字段列表，多个字段采用逗号分隔。
* constraintOption: 约束检查选项，缺省值为null,不进行约束检查。目前支持两类约束性检查：
*                    一类是：唯一性约束检查，当进行唯一性约束检查的时候该选项要设置以下字段内容：
*                    {
*                      table4Check:要检查的表格名称，
*                      Constraint:"unique",
*                      ExpandToYearFileds:"",检查时将日期范围扩展到年范围的字段，用多个之间用逗号分隔
*                      checkFields:要进行约束检查的字段名称，多个字段名称用逗号分隔表示两个条件必须都满足，如果用|表示满足其中一个就说明不唯一。
*                    }
*                   第二类是：针对数字内容的范围检查，就是检查用户输入的值在数据库中是否已经在指定的字段范围之内：
*                    {
*                      table4Check:要检查的表格名称，
*                      Constraint:"range",
*                      minField:  要进行检查的包括范围的最低值字段名称  
*                      maxField:  要进行检查的包括范围的最高值字段名称
*                    }
*
*
*
***************************************/
function initTb4Grid(grid, processChangeUrl, createInitOption, backurl, buttonMask, onBeforeSave, needToolTipFields, constraintOption) {
    currProcessingIndex = -1;
    var toolbar = [];
    if (buttonMask && buttonMask == 10) {
        toolbar = [{ text: '编辑', iconCls: 'icon-edit', handler: function () { editGridRow(grid); } },
                   { text: "保存", iconCls: "icon-save", handler: function () { saveGrid(grid, processChangeUrl, onBeforeSave, constraintOption); } }];
    }
    if (buttonMask && buttonMask == 1) {
        toolbar = [{ text: '新建', iconCls: 'icon-add', handler: function () { createNewGridRow(grid, createInitOption); } },
                   { text: '编辑', iconCls: 'icon-edit', handler: function () { editGridRow(grid); } },
                   { text: '删除', iconCls: 'icon-remove', handler: function () { deleteGridRow(grid, processChangeUrl, onBeforeSave); } }];
    }
    else if (buttonMask && buttonMask == 0) {
    }
    else {
        toolbar = [{ text: '新建', iconCls: 'icon-add', handler: function () { createNewGridRow(grid, createInitOption); } },
                   { text: '编辑', iconCls: 'icon-edit', handler: function () { editGridRow(grid); } },
                   { text: '删除', iconCls: 'icon-remove', handler: function () { deleteGridRow(grid, processChangeUrl, onBeforeSave); } },
                   { text: "保存", iconCls: "icon-save", handler: function () { saveGrid(grid, processChangeUrl, onBeforeSave, constraintOption); } }];
    }
    if (backurl && backurl.length > 0) {
        toolbar.push({ text: "返回", iconCls: "icon-back", handler: function () { backLevel(grid, backurl); } });
    }
    
    var options = {
        toolbar: toolbar,
        onSelect: function (rowIndex, rowData) {
            onRowSelect(grid, processChangeUrl, rowIndex, rowData, onBeforeSave, constraintOption);
        },
        onLoadSuccess: function (data) {
            if (data != undefined && grid.datagrid("getRows").length > 0) {
                grid.datagrid("selectRow", 0);
                if (needToolTipFields && needToolTipFields.length > 0) {
                    var filedNames = needToolTipFields.split(",");
                    for (var i = 0; i < filedNames.length; i++) {
                        AddToolTip4GridField(grid, filedNames[i]);
                    }
                }
                //call old method
                if(constraintOption.onLoadSuccess)
                    constraintOption.onLoadSuccess(data);
            }
        },
        onBeforeLoad: function (param) {
            var retVal = true;
            if (currProcessingIndex != -1) {
                retVal = false;
                $.messager.confirm('放弃', '当前有数据未保存，确实要放弃做的修改吗？', function (r) {
                    if (r) {
                        currProcessingIndex = -1;
                        grid.datagrid("reload");
                    }
                });
            }
            return retVal;
        }
    };
    jQuery.extend(options, constraintOption);
    grid.datagrid(options);

    grid.datagrid('getPager').pagination({
        //pageSize: 20,//每页显示的记录条数，默认为20  
        pageNumber: 1,
        pageList: [5, 10, 15, 20, 25],//可以设置每页记录条数的列表  
        beforePageText: '第',//页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    /////////////////////////////////////////////////////////////////////////////
    //是否有修改数据
    /////////////////////////////////////////////////////////////////////////////   
    haveChanges = function () { return getChanges(grid); };
}

function onRowSelect(grid, url, rowIndex, rowData, onBeforeSave, constraintOption) {
    if (currProcessingIndex != -1 && rowIndex != currProcessingIndex) {
        $.messager.confirm('确认', '当前数据未保存，是否保存该数据？', function (r) {
            if (r) {
                saveGrid(grid, url, onBeforeSave, constraintOption);
            }
            else {
                currProcessingIndex = -1;
                grid.datagrid('rejectChanges');
            }
        });
    }
}

function createNewGridRow(grid, options) {
    if (!getChanges(grid)) {
        options = options || {};
        grid.datagrid('appendRow', options);
        var rows = grid.datagrid('getRows');
        grid.datagrid('beginEdit', rows.length - 1);
        currProcessingIndex = rows.length - 1;
        grid.datagrid('selectRow', currProcessingIndex);
    }
    else {
        showAlertMessage("您好，您有一条数据正在编辑请先保存该数据后再创建！", 0);
    }
}

function getEditRowIndex(grid) {
    var rowIndex = -1;
    var row = grid.datagrid('getSelected');
    if (row) {
        rowIndex = grid.datagrid('getRowIndex', row);
    }
    return rowIndex;
}

function editGridRow(grid) {
    if (!getChanges(grid)) {
        var row = grid.datagrid('getSelected');
        if (row) {
            var rowIndex = grid.datagrid('getRowIndex', row);
            grid.datagrid('beginEdit', rowIndex);
            currProcessingIndex = rowIndex;
        } else {
            showAlertMessage("请选择要编辑的行！", 0);
        }
    }
    else {
        showAlertMessage("您已经在编辑该行数据，不要重复点击该操作！", 0);
    }
}

function deleteGridRow(grid, url, onBeforeSave) {
    var row = grid.datagrid('getSelected');
    if (row) {
        $.messager.confirm("删除", "确实要删除该行吗？", function (r) {
            if (r) {
                var rowIndex = grid.datagrid('getRowIndex', row);
                grid.datagrid('deleteRow', rowIndex);
                if (url) {
                    saveGrid(grid, url, onBeforeSave);
                }
                return true;
            }
        });
    } else {
        showAlertMessage("请选择要删除该行！", 0);
        return false;
    }
    return false;
}


function endEditGridRow(grid, onBeforeSave) {
    var rows = grid.datagrid('getRows');
    //var currEditRow=getEditRowIndex(grid);
    var valid = true;
    for (var i = 0; i < rows.length; i++) {
        if (grid.datagrid('validateRow', i) == false) {
            grid.datagrid('selectRow', i);
            showAlertMessage("不能保存该数据，请将必填项填写完整。", 0);
            valid = false;
            return valid;
        }
        if (i == currProcessingIndex && onBeforeSave && $.isFunction(onBeforeSave)) {//提交前增加额外校验或处理，如果返回false将取消提交
            if (!onBeforeSave(grid, rows[i], i)) {
                return false;
            }
        }
        grid.datagrid('endEdit', i);
    }
    return valid;
}


function isExpandToYearField(ExpandToYearFileds,field) {
    var retb = false;
    if (ExpandToYearFileds && field) {
        var strExpandToYearFileds = ExpandToYearFileds + "";//avoid error if ExpandToYearFileds is not string.
        var fieldlist = strExpandToYearFileds.split(",");
        for (var i = 0; i < fieldlist.length; i++) {
            if (field == fieldlist[i]) {
                retb = true;
                break;
            }
        }
    }
    return retb;
}

function getKeyValStr(src, constraintOption) {    
    var retStr = "";
    if (constraintOption && constraintOption.Constraint) {
        var keys = [];        
        if (constraintOption.Constraint == "unique") {
            if (constraintOption.checkFields && constraintOption.checkFields.length > 0) {
                keys = replaceSpecialChar2Comma(constraintOption.checkFields).split(",");
                retStr = constraintOption.checkFields;
                for (var i = 0; i < keys.length; i++) {
                    if(isExpandToYearField(constraintOption.ExpandToYearFileds,keys[i])){                        
                        var d = new Date(src[keys[i]]);
                        console_trace(new Date(d.getFullYear(), 1, 1).getTime());
                        var startTicks = new Date(d.getFullYear(), 1, 1).getTime() * 10000 + 621329472000000000;//31536000000                        
                        var tmpStr = "(" + keys[i] + ">=$DT$(" + startTicks + ")";
                        tmpStr = tmpStr + "," + keys[i] + "<$DT$(" + (startTicks + 365*24*3600*10000000) + "))";
                        retStr = retStr.replace(new RegExp(keys[i]), tmpStr)
                    }
                    else{
                        var tmpStr = keys[i] + ($.isNumeric(src[keys[i]]) ? "=" : "=\"") + src[keys[i]] + ($.isNumeric(src[keys[i]]) ? "" : "\"");
                        retStr = retStr.replace(new RegExp(keys[i]), tmpStr)
                    }                   
                }                
            }            
        }
        else if (constraintOption.Constraint == "range") {
            if (constraintOption.minField && constraintOption.minField.length > 0 && constraintOption.maxField && constraintOption.maxField.length > 0) {
                var isNum = $.isNumeric(src[constraintOption.minField]);                
                retStr = "("+constraintOption.minField + (isNum ? "<" : "<\"") + src[constraintOption.minField] + (isNum ? "," : "\",");
                retStr = retStr + constraintOption.maxField + (isNum ? ">" : ">\"") + src[constraintOption.minField] + (isNum ? ") | (" : "\") | (");
                retStr = retStr + constraintOption.minField + (isNum ? "<" : "<\"") + src[constraintOption.maxField] + (isNum ? "," : "\",");
                retStr = retStr + constraintOption.maxField + (isNum ? ">" : ">\"") + src[constraintOption.maxField] + (isNum ? ")" : "\")");
            }
        }        
    }    
    return retStr;
}

function getConstraintMsg(grid, constraintOption) {
    var retMsg = "";    
    if (constraintOption.Constraint == 'unique') {
        retMsg = "字段(" + getColumnTitles(grid, constraintOption.checkFields) + ")的值不能重复，请检查！";
    }
    else if (constraintOption.Constraint == 'range') {
        retMsg = "字段(" + getColumnTitles(grid, constraintOption.minField + "," + constraintOption.maxField) + ")的值不能在以前定义过的范围之内，请检查！";
    }
    return retMsg;
}
function replaceSpecialChar2Comma(fieldlist) {
    var tmp = fieldlist.replace(/\(/g, "");
    tmp = tmp.replace(/\)/g, "");
    tmp = tmp.replace(/\|/g, ",");
    return tmp;
}

function getColumnTitles(grid, fieldlist) {    
    var fields = replaceSpecialChar2Comma(fieldlist).split(",");
    var retStr = "";
    for (var i = 0; i < fields.length; i++) {
        var columnOpt = grid.datagrid("getColumnOption", fields[i]);
        if (columnOpt.field != columnOpt.title) {
            retStr = retStr + columnOpt.title + ",";
        }
    }
    return retStr.substr(0, retStr.length - 1);
}

function saveGrid(grid, url, onBeforeSave, constraintOption) {
    if (endEditGridRow(grid, onBeforeSave) == false) { return false; }
    if (grid.datagrid('getChanges').length) {
        var inserted = grid.datagrid('getChanges', "inserted");
        var deleted = grid.datagrid('getChanges', "deleted");
        var updated = grid.datagrid('getChanges', "updated");

        var effectRow = new Object();
        var conditionStr = "";
        var msg = "保存";
        if (inserted.length) {
            effectRow["inserted"] = JSON.stringify(inserted);
            if (constraintOption != undefined) {
                if ((constraintOption.checkFields && constraintOption.checkFields.length > 0) ||
                (constraintOption.minField && constraintOption.minField.length > 0)) {
                    conditionStr = getKeyValStr(inserted[0], constraintOption);
                }
            }
        }
        if (deleted.length) {
            effectRow["deleted"] = JSON.stringify(deleted, grid.datagrid('getColumnFields'));
            msg = "删除";
        }
        if (updated.length) {
            effectRow["updated"] = JSON.stringify(updated, grid.datagrid('getColumnFields'));
            if (constraintOption != undefined) {
                if ((constraintOption.checkFields && constraintOption.checkFields.length > 0) ||
                (constraintOption.minField && constraintOption.minField.length > 0)) {
                    conditionStr = getKeyValStr(updated[0], constraintOption);
                }
            }
        }
        console_trace(effectRow);
        //进行唯一性约束检查
        if (constraintOption && constraintOption.table4Check && constraintOption.Constraint && constraintOption.table4Check.length > 0 && constraintOption.Constraint.length > 0) {
            effectRow.targetTable = constraintOption.table4Check;
            var needCheckFromServer = true;
            if (updated.length) {
                var originalData = $(grid).data('datagrid').originalRows;
                if (conditionStr == getKeyValStr(originalData[currProcessingIndex], constraintOption)) {
                    needCheckFromServer = false;
                }
            }
            if (needCheckFromServer && conditionStr.length > 0) {
                var r = processCheckUnique(constraintOption.table4Check, conditionStr);
                var needExit = false;
                var showMsg = "";
                if (r == 0) {
                    showMsg = getConstraintMsg(grid, constraintOption);
                    needExit = true;
                }
                else if (r == -1) {
                    showMsg = "检查唯一约束的表的名称不对，请相关技术人员检查！";
                    needExit = true;
                }
                else if (r == -2) {
                    showMsg = "网络故障请联系相关的技术人员，请相关技术人员检查！！";
                    needExit = true;
                }
                if (needExit) {
                    showAlertMessage(showMsg, 2);
                    grid.datagrid('beginEdit', currProcessingIndex);
                    grid.datagrid('selectRow', currProcessingIndex);
                    return false;
                }
            }
        }
        //提交数据保存
        $.post(url, effectRow, function (rsp) {
            if (rsp.status) {
                showSuccessMsgbox(msg + "成功！");
                grid.datagrid('acceptChanges');
                currProcessingIndex = -1;
                if (deleted.length > 0) {
                    var current = grid.datagrid("getRows");
                    var pageNumber = grid.datagrid("options").pageNumber;
                    if (current.length == 0 && (pageNumber > 1)) {
                        grid.datagrid("getPager").pagination('select', pageNumber - 1);
                    }
                    else {
                        grid.datagrid('reload');
                    }
                }
                else {
                    grid.datagrid("reload");
                }
            } else {
                showAlertMessage(rsp.msg, 2);
                grid.datagrid("reload");
            }
        }, "JSON").error(function () {
            showAlertMessage(msg + "失败！", 2);
            grid.datagrid("reload");
        });
    }
    else {
        currProcessingIndex = -1;
    }
}
function setGridPage(grid, page, id) {
    if (!page)
        return;
    var row;
    var params = grid.datagrid('options').queryParams;
    var count = 0;
    $.each(params, function (key, value) {
        count++;
    });
    if (count == 0)
        return;
    var data = grid.datagrid('getData');
    if (id) {
        row = id;
    }
    else {
        var rows = data.rows;
        $.each(params, function (key, value) {
            rows = $.grep(rows, function (v, i) {
                return v[key] == value;
            });
        });
        if (rows.length > 0)
            row = rows[0];
    }
    if (!row)
        return;
    var idx = grid.datagrid('getRowIndex', row);
    if (idx > -1) {
        grid.datagrid('selectRow', idx);
    }
    grid.datagrid('options').queryParams = {};
    grid.datagrid('options').pageNumber = page;
    grid.datagrid('getPager').pagination('refresh', { pageNumber: page });
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
//.Net Date proecess
//////////////////////////////////////////////////////////////////////////
function convertJson2Date(value) {
    if (value && value.indexOf("Date") > -1) {
        var tmpMatch = value.match(/\d+/g);
        if (tmpMatch && tmpMatch[0]) {
            var tmpDate = new Date();
            tmpDate.setTime(tmpMatch[0]);
            return tmpDate.getFullYear() + "-" + (tmpDate.getMonth() + 1) + "-" + tmpDate.getDate();;
        }
    }
    return value;
}

function convertStr2Date(dateStr) {
    return new Date(dateStr.replace(/-/g, "/"));
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////
//console_trace(obj)
////////////////////////////////////////////////////////////////////////////////////////////////////////

function console_trace(obj) {
    window.console && console.info(obj);
}

////////////////////////////////////////////////////////////////////////////////////////
//message
////////////////////////////////////////////////////////////////////////////////////////

function showSuccessMsgbox(msg) {
    msg = '<div class="messager_success"></div><div style="margin-top:15px;">' + msg + '</div>';
    $.messager.show({
        title: '成功',
        msg: msg,
        timeout: 2000,
        showSpeed: 500,
        showType: 'fade',
        style: {
            right: '',
            bottom: ''
        }
    });
}

function showAlertMessage(msg, type) {
    //type: error,question,info,warning
    if (type == 0) {
        $.messager.alert("提示", msg, "info");
    } else if (type == 1) {
        $.messager.alert("警告", msg, "warning");
    } else if (type == 2) {
        $.messager.alert("错误", msg, "error");
    } else if (type == 3) {
        $.messager.alert("问题", msg, "question");
    } else {
        $.messager.alert("消息", msg);
    }
}
function showConfirm(msg, callbackok, callbackcancel, paramOk, paramCancel) {
    $.messager.confirm('提示', msg,
            function (r) {
                if (r) {
                    if (callbackok != undefined && callbackok != null && typeof (callbackok) == 'function') {
                        if (paramOk) {
                            callbackok(paramOk);
                        } else {
                            callbackok();
                        }
                    }
                } else {
                    if (callbackcancel != undefined && callbackcancel != null && typeof (callbackcancel) == 'function') {
                        if (paramCancel) {
                            callbackcancel(paramCancel);
                        } else {
                            callbackcancel();
                        }
                    }
                }
            });
}

function showTips() {
    $.each(tips, function (i, v) {
        showTip(v, window[v]);
    });
}
function showTip(className, tipMsg) {
    var obj = $('.' + className);
    if (obj.length > 0) {
        if (!obj.hasClass('tip'))
            obj.addClass('tip');
        if (obj.find('.tip_icon').length == 0 && obj.find('.tip_message').length == 0)
            obj.append('<div class="tip_icon"></div><div class="tip_message">' + tipMsg + '</div>');
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////
//在多个元素中将指定元素置为可用,而其他元素置为不可用
////////////////////////////////////////////////////////////////////////////////////////////////////////
function setLinkButtonEnable(sSourceIDs, sEnableIDs) {
    if (!sSourceIDs) return;
    var arySourceID = sSourceIDs.split(",");
    var aryEnableID = new Array();
    if (sEnableIDs) {
        aryEnableID = sEnableIDs.split(",");
    }
    var sJqSourceID = "";
    var sourceID = "";
    for (var i = 0; i < arySourceID.length; i++) {
        sourceID = arySourceID[i];
        sJqSourceID = "#" + sourceID;
        if (isStrInAry(sourceID, aryEnableID)) {
            $(sJqSourceID).linkbutton('enable');
        } else {
            $(sJqSourceID).linkbutton('disable');
        }
    }
}

function isStrInAry(sTarget, aryStr) {
    var str = "";
    for (var i = 0; i < aryStr.length; i++) {
        str = aryStr[i];
        if (str == sTarget) {
            return true;
        }
    }
    return false;
}

//json string preprocess
String.prototype.parseJSONWithBR = function () {
    //return this.replace(/\r/g, '\\r').replace(/\n/g, '\\n');
    var sOld = this.replace(/\\/g, '\\\\').replace(/\r/g, '\\r').replace(/\n/g, '\\n');
    var sNew = sOld;
    var re = /(\"\w+\":\")((.|\n)*?)((\",\"\w+\":)|(\"\}))/g;
    var sSubOld = "";
    var sSubNew = "";
    while (re.exec(sOld)) {
        sSubOld = RegExp.$2;
        sSubNew = sSubOld.replace(/\"/g, '\\"');
        sNew = sNew.replace(sSubOld, sSubNew);
    };
    return sNew;

}
//时间区间校验
$.extend($.fn.validatebox.defaults.rules, {
    isafter: {
        validator: function (value, param) {
            var isOK = true;
            if (value != "" && $(param[0]).datebox('getValue') != "") {
                var dateA = $.fn.datebox.defaults.parser(value);
                var dateB = $.fn.datebox.defaults.parser($(param[0]).datebox('getValue'));
                isOK = dateA >= dateB;
            }
            return isOK;
        },
        message: '结束日期必须大于等于起始日期'
    },
    isbefore: {
        validator: function (value, param) {
            var isOK = true;
            if (value != "" && $(param[0]).datebox('getValue') != "") {
                var dateA = $.fn.datebox.defaults.parser(value);
                var dateB = $.fn.datebox.defaults.parser($(param[0]).datebox('getValue'));
                isOK = dateA <= dateB;
            }
            return isOK;
        },
        message: '起始日期必须小于等于结束日期'
    },
    isafterNow: {
        validator: function (value) {
            var isOK = true;
            if (value != "") {
                var dateA = $.fn.datebox.defaults.parser(value);
                var today = new Date();
                var dateB = new Date(today.getFullYear(), today.getMonth(), today.getDate());
                isOK = dateA >= dateB;
            }
            return isOK;
        },
        message: '结束日期必须大于等于当前日期'
    }
});


//保留2位小数
function formatNumber(val) {
    if (val) {
        return Number(val).toFixed(2);
    }
    return val;
}

//64位编码函数
var base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
var base64DecodeChars = new Array(
-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63,
52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1,
-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1,
-1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1);
//客户端Base64编码
function base64encode(str) {
    var out, i, len;
    var c1, c2, c3;
    len = str.length;
    i = 0;
    out = "";
    while (i < len) {
        c1 = str.charCodeAt(i++) & 0xff;
        if (i == len) {
            out += base64EncodeChars.charAt(c1 >> 2);
            out += base64EncodeChars.charAt((c1 & 0x3) << 4);
            out += "==";
            break;
        }
        c2 = str.charCodeAt(i++);
        if (i == len) {
            out += base64EncodeChars.charAt(c1 >> 2);
            out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
            out += base64EncodeChars.charAt((c2 & 0xF) << 2);
            out += "=";
            break;
        }
        c3 = str.charCodeAt(i++);
        out += base64EncodeChars.charAt(c1 >> 2);
        out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
        out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6));
        out += base64EncodeChars.charAt(c3 & 0x3F);
    }
    return out;
}
//客户端Base64解码
function base64decode(str) {
    var c1, c2, c3, c4;
    var i, len, out;
    len = str.length;
    i = 0;
    out = "";
    while (i < len) {
        /* c1 */
        do {
            c1 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
        } while (i < len && c1 == -1);
        if (c1 == -1)
            break;
        /* c2 */
        do {
            c2 = base64DecodeChars[str.charCodeAt(i++) & 0xff];
        } while (i < len && c2 == -1);
        if (c2 == -1)
            break;
        out += String.fromCharCode((c1 << 2) | ((c2 & 0x30) >> 4));
        /* c3 */
        do {
            c3 = str.charCodeAt(i++) & 0xff;
            if (c3 == 61)
                return out;
            c3 = base64DecodeChars[c3];
        } while (i < len && c3 == -1);
        if (c3 == -1)
            break;
        out += String.fromCharCode(((c2 & 0XF) << 4) | ((c3 & 0x3C) >> 2));
        /* c4 */
        do {
            c4 = str.charCodeAt(i++) & 0xff;
            if (c4 == 61)
                return out;
            c4 = base64DecodeChars[c4];
        } while (i < len && c4 == -1);
        if (c4 == -1)
            break;
        out += String.fromCharCode(((c3 & 0x03) << 6) | c4);
    }
    return out;
}

//基于form的表单搜索的通用函数
function getQueryString(queryForm) {
    var fields = queryForm.serializeArray(); //自动序列化表单元素为JSON对象
    var qStr = base64encode(JSON.stringify(fields)); //保存查询参数
    return qStr;
}
//根据搜索表单装载grid数据
function goQueryByForm(queryForm,dataGrid,gridUrl ,bSavequeryParams) {
    var params;
    if ((bSavequeryParams != undefined) && (bSavequeryParams))
        params = dataGrid.datagrid('options').queryParams; //先取得 datagrid 的查询参数
    else
        params = new Object();
    if((gridUrl!=undefined)&&(gridUrl!=null))
        dataGrid.datagrid('options').url = gridUrl;
    var fields = queryForm.serializeArray(); //自动序列化表单元素为JSON对象

    $.each(fields, function (i, field) {
        if((field.value!=undefined)&&(field.value!=null)&&(field.value!=""))
            params[field.name] = field.value; //设置查询参数  
    });
    //dataGrid.datagrid('options').queryParams=params;
    dataGrid.datagrid('load', params); //设置好查询参数 load 一下就可以了  
}


//根据返回的搜索字符串，重新给搜索表单赋值，产生更新grid的URL
function setQueryParamToForm(queryParm,queryForm) {

    var url = "";
    if (queryParm.length > 0) {
        queryParm = base64decode(queryParm);

        var fields = $.parseJSON(queryParm);
        var obj = new Object;
        $.each(fields, function (i, field) {
            obj[field.name] = field.value; //设置查询参数
            if (field.value.length > 0) {
                url += "&" + field.name + "=" + field.value;
            }
        });
        queryForm.form("load", obj);
    }
    return url;

}

//*********************************************************
//              上传、下载
//*******************************************************/
function download(url,param) {
    var form = $('<form name="hidden_download_form">');
    form.attr('style', 'display:none');
    form.attr('target', '');
    form.attr('method', 'post');
    form.attr('action', url);

    var input1 = $('<input type="hidden" name="hidden_download_input">');
    input1.attr('value', param);

    $('body').append(form);
    form.append(input1);

    form.submit();
    form.remove();
}

//**********************************************************//