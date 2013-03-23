/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

//////////////////////////////////////////////////////////////////////////
/*
 *	menu 
 */
var selectedTopMenuItem = null; // top menu button
var haveChanges, currProcessingIndex = -1;

function changmenm(obj) {
    if (selectedTopMenuItem == obj) {
        return;
    }
    if (selectedTopMenuItem) {
        selectedTopMenuItem.className = "nav_up";
    }
    obj.className = "nav_selected";
    selectedTopMenuItem = obj;
}
;
function mouseOver(obj) {
    if (selectedTopMenuItem != obj)
        obj.className = "nav_over";
}
;
function mouseOut(obj) {
    if (selectedTopMenuItem != obj)
        obj.className = "nav_up";
}
;

function ChangeModule(url) {
    if (url && url.length == 0) {
        showAlertMessage("当前版本没有实现该功能！", 0);
        return false;
    }

    if (haveChanges) {    // 判断是否加载了函数(用于检查要卸载的内容是否都保存了)。
        if (haveChanges()) { // 执行卸载函数。true：有未保存的内容，返回原界面；false:没有有未保存的内容。
            $.messager.confirm("放弃", "确实要放弃做的修改吗？", function(r) {
                if (r) {
                    window.location.assign(url);
                }
            });
        }
        else {
            window.location.assign(url);
        }
    }
    else {
        window.location.assign(url);
    }
}

function GetContent(str) {
    if ("" == str) {
        showAlertMessage("当前版本没有实现该功能！", 0);
        return false;
    }
    if (haveChanges) {    // 判断是否加载了函数(用于检查要卸载的内容是否都保存了)。
        if (haveChanges()) { // 执行卸载函数。true：有未保存的内容，返回原界面；false:没有有未保存的内容。
            $.messager.confirm("放弃", "确实要放弃做的修改吗？", function(r) {
                if (r) {
                    updateContent(str);
                }
            });
        } else {
            updateContent(str);
        }
    } else {
        updateContent(str);
    }
}
;

function updateContent(str) {
    haveChanges = undefined;
    /*removePriviousDomId("employee_dlg");
    removePriviousDomId("employment_dlg");
    removePriviousDomId("indicator_dlg");
    removePriviousDomId("userDlg");
    removePriviousDomId("roleDlg");
    removePriviousDomId("rolePrivilegeDlg");
    removePriviousDomId("userRoleDlg");
    removePriviousDomId("licence_dlg");*/
    $("#contentPanel").empty();
    $("#contentPanel").load(str, "width=" + $("#contentPanel").width() + "&height=" + $("#contentPanel").height(), function() {
        showTips();
    });
    //$("#contentPanel").load(str);
}

String.prototype.parseJSONDate = function() {
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
function getCheckedDivision(treeId) {
    return getChecked(treeId, "ParentDivisionId");
}
function getCheckedEmployee(treeId) {
    return getChecked(treeId, "employeeName");
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
            $.messager.confirm("删除", "确实要放弃所作的修改吗？", function(r) {
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
    $.each(fields, function(i, n) {
        if (i == 0) {
            return;
        }
        $(this).qtip({
            content: "" + $(this).text(),
            position: {
                target: 'mouse',
                //corner: { target: 'topRight', tooltip: 'bottomLeft' },
                corner: {target: 'bottomMiddle', tooltip: 'topMiddle'},
                // corner:　{target:'mouse'},
                adjust: {mouse: true, scroll: true}
            },
            show: {solo: true},
            hide: {delay: 800},
            style: {
                border: {radius: 0, width: 1},
                //padding: '5px　15px', //　Give　it　some　extra　padding　
                tip: true,
                name: 'blue'//　And　style　it　with　the　preset　dark　theme　
            }
        });
    });
}

function initTb4Grid(grid, processChangeUrl, createInitOption, backurl, onBeforeSave, needToolTipFields, table4CheckUnique, uniqueFields, ButtonMask) {
    currProcessingIndex = -1;
    var toolbar = [];
    if (ButtonMask && ButtonMask == 10) {
        toolbar = [{text: '编辑', iconCls: 'icon-edit', handler: function() {
                    editGridRow(grid);
                }},
            {text: "保存", iconCls: "icon-save", handler: function() {
                    saveGrid(grid, processChangeUrl, onBeforeSave, table4CheckUnique, uniqueFields);
                }}];
    }
    else if (ButtonMask && ButtonMask == 0) {
    }
    else {
        toolbar = [{text: '新建', iconCls: 'icon-add', handler: function() {
                    createNewGridRow(grid, createInitOption);
                }},
            {text: '编辑', iconCls: 'icon-edit', handler: function() {
                    editGridRow(grid);
                }},
            {text: '删除', iconCls: 'icon-remove', handler: function() {
                    deleteGridRow(grid, processChangeUrl, onBeforeSave);
                }},
            {text: "保存", iconCls: "icon-save", handler: function() {
                    saveGrid(grid, processChangeUrl, onBeforeSave, table4CheckUnique, uniqueFields);
                }}];
    }
    if (backurl && backurl.length > 0) {
        toolbar.push({text: "返回", iconCls: "icon-back", handler: function() {
                backLevel(grid, backurl);
            }});
    }
    var existLoadSucessFunc = grid.datagrid("options").onLoadSuccess;

    grid.datagrid({
        toolbar: toolbar,
        onSelect: function(rowIndex, rowData) {
            onRowSelect(grid, processChangeUrl, rowIndex, rowData, onBeforeSave, table4CheckUnique, uniqueFields);
        },
        onLoadSuccess: function(data) {
            if (data != undefined && grid.datagrid("getRows").length > 0) {
                grid.datagrid("selectRow", 0);
                if (needToolTipFields && needToolTipFields.length > 0) {
                    var filedNames = needToolTipFields.split(",");
                    for (var i = 0; i < filedNames.length; i++) {
                        AddToolTip4GridField(grid, filedNames[i]);
                    }
                }
                //call old method
                existLoadSucessFunc(data);
            }
        },
        onBeforeLoad: function(param) {
            var retVal = true;
            if (currProcessingIndex != -1) {
                retVal = false;
                $.messager.confirm('放弃', '当前有数据未保存，确实要放弃做的修改吗？', function(r) {
                    if (r) {
                        currProcessingIndex = -1;
                        grid.datagrid("reload");
                    }
                });
            }
            return retVal;
        }
    });

    grid.datagrid('getPager').pagination({
        //pageSize: 20,//每页显示的记录条数，默认为20  
        pageNumber: 1,
        pageList: [5, 10, 15, 20, 25], //可以设置每页记录条数的列表  
        beforePageText: '第', //页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
    });
    /////////////////////////////////////////////////////////////////////////////
    //是否有修改数据
    /////////////////////////////////////////////////////////////////////////////   
    haveChanges = function() {
        return getChanges(grid);
    };
}

function onRowSelect(grid, url, rowIndex, rowData, onBeforeSave, table4CheckUnique, uniqueFields) {
    if (currProcessingIndex != -1 && rowIndex != currProcessingIndex) {
        $.messager.confirm('确认', '当前数据未保存，是否保存该数据？', function(r) {
            if (r) {
                saveGrid(grid, url, onBeforeSave, table4CheckUnique, uniqueFields);
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
        $.messager.confirm("删除", "确实要删除该行吗？", function(r) {
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

function processCheckUnique(table4CheckUnique, conditionstr) {
    var retVal = -2;
    $.ajax({
        url: '/BasePerformance/IsUnique',
        data: {strTableName: table4CheckUnique, fieldValues: conditionstr},
        type: 'POST',
        async: false, dataType: "json",
        success: function(rsp) {
            if (rsp) {
                retVal = rsp.result;
            } else {
                showAlertMessage("检查唯一性约束出错，请联系相关技术人员！！", 2);
            }
        }
    });
    return retVal;
}

function getKeyValStr(src, keylist) {
    var keys = keylist.split(",");
    var retStr = "";
    for (var i = 0; i < keys.length; i++) {
        retStr = retStr + keys[i] + "=" + src[keys[i]] + ",";
    }
    return retStr.substr(0, retStr.length - 1);
}

function getColumnTitles(grid, fieldlist) {
    var fields = fieldlist.split(",");
    var retStr = "";
    for (var i = 0; i < fields.length; i++) {
        var columnOpt = grid.datagrid("getColumnOption", fields[i]);
        if (columnOpt.field != columnOpt.title) {
            retStr = retStr + columnOpt.title + ",";
        }
    }
    return retStr.substr(0, retStr.length - 1);
}

function saveGrid(grid, url, onBeforeSave, table4CheckUnique, uniqueFields) {
    if (endEditGridRow(grid, onBeforeSave) == false) {
        return false;
    }
    if (grid.datagrid('getChanges').length) {
        var inserted = grid.datagrid('getChanges', "inserted");
        var deleted = grid.datagrid('getChanges', "deleted");
        var updated = grid.datagrid('getChanges', "updated");

        var effectRow = new Object();
        var conditionStr = "";
        var msg = "保存";
        if (inserted.length) {
            effectRow["inserted"] = JSON.stringify(inserted);
            if (uniqueFields != null && uniqueFields != "" && uniqueFields != "undefined") {
                conditionStr = getKeyValStr(inserted[0], uniqueFields);
            }
        }
        if (deleted.length) {
            effectRow["deleted"] = JSON.stringify(deleted, grid.datagrid('getColumnFields'));
            msg = "删除";
        }
        if (updated.length) {
            effectRow["updated"] = JSON.stringify(updated, grid.datagrid('getColumnFields'));
            if (uniqueFields != null && uniqueFields != "" && uniqueFields != "undefined") {
                conditionStr = getKeyValStr(updated[0], uniqueFields);
            }
        }
        console_trace(effectRow);
        //进行唯一性约束检查
        if (table4CheckUnique && uniqueFields && table4CheckUnique.length > 0 && uniqueFields.length > 0) {
            var needCheckFromServer = true;
            if (updated.length) {
                var originalData = grid.datagrid("getRows");
                if (conditionStr == getKeyValStr(originalData[currProcessingIndex], uniqueFields)) {
                    needCheckFromServer = false;
                }
            }
            if (needCheckFromServer && conditionStr.length > 0) {
                var r = processCheckUnique(table4CheckUnique, conditionStr);
                var needExit = false;
                var showMsg = "";
                if (r == 0) {
                    showMsg = "字段(" + getColumnTitles(grid, uniqueFields) + ")的值不能重复，请检查！";
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
        $.post(url, effectRow, function(rsp) {
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
        }, "JSON").error(function() {
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
    $.each(params, function(key, value) {
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
        $.each(params, function(key, value) {
            rows = $.grep(rows, function(v, i) {
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
    grid.datagrid('getPager').pagination('refresh', {pageNumber: page});
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
//.Net Date proecess
//////////////////////////////////////////////////////////////////////////
function convertNetJson2Date(value) {
    if (value && value.indexOf("Date") > -1) {
        var tmpMatch = value.match(/\d+/g);
        if (tmpMatch && tmpMatch[0]) {
            var tmpDate = new Date();
            tmpDate.setTime(tmpMatch[0]);
            return tmpDate.getFullYear() + "-" + (tmpDate.getMonth() + 1) + "-" + tmpDate.getDate();
            ;
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
            function(r) {
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
    $.each(tips, function(i, v) {
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
    if (!sSourceIDs)
        return;
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
String.prototype.parseJSONWithBR = function() {
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
    }
    ;
    return sNew;

}
//时间区间校验
$.extend($.fn.validatebox.defaults.rules, {
    isafter: {
        validator: function(value, param) {
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
        validator: function(value, param) {
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
        validator: function(value) {
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
