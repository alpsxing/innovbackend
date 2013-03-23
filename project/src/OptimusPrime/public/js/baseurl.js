/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function GetBaseUrl() {
    try {
        var url = location.href;
        var start = url.indexOf('//');
        if (start < 0)
        {
            start = 0
        } else {
            start = start + 2;
        }
        
        var end = url.indexOf('/', start);
        if (end < 0)
            end = url.length - start;
        var baseURL = url.substring(0, end);
        return baseURL;
    }
    catch (arg) {
        return null;
    }
}

