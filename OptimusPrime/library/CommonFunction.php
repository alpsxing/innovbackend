<?PHP
function getClientIp()
{
// 初始化一个变量$realip
    static $realip = NULL;
    // 如果$realip不真等于NULL,返回之
    if ($realip !== NULL)
    {
        return $realip;
    }
// 如果$_SERVER有值
    if (isset($_SERVER))
    {
     // 如果$_SERVER[''HTTP_X_FORWARDED_FOR'']有值
     // 表明客户端通过代理上网
        if (isset($_SERVER['HTTP_X_FORWARDED_FOR']))
        {
         // 使用explode()函数将其用'',''分割成数组
            $arr = explode('','', $_SERVER[HTTP_X_FORWARDED_FOR]);
            /* 取X-Forwarded-For中第一个非unknown的有效IP字符串 */
            // 开始遍历数组
            foreach ($arr AS $ip)
            {
             // 去掉首尾的空白
                $ip = trim($ip);
    // 不是unknown就是真实上网地址,存值并退出循环
                if ($ip != 'unknown')
                {
                    $realip = $ip;
                    break;
                }
            }
        }
        // $_SERVER[''HTTP_X_FORWARDED_FOR'']无值 且
        // $_SERVER[''HTTP_CLIENT_IP'']有值，取其值作为真实IP
        elseif (isset($_SERVER['HTTP_CLIENT_IP']))
        {
            $realip = $_SERVER['HTTP_CLIENT_IP'];
        }
        // $_SERVER[''HTTP_X_FORWARDED_FOR'']无值(不是用过代理上网)并且
        // $_SERVER[''HTTP_CLIENT_IP'']也没有值
        else
        {
         // 如果$_SERVER[''REMOTE_ADDR'']有值，取其值作为真实IP
            if (isset($_SERVER['REMOTE_ADDR']))
            {
                $realip = $_SERVER['REMOTE_ADDR'];
            }
            else // 都没有值返回''0.0.0.0''
            {
                $realip = '0.0.0.0';
            }
        }
    }
    // $_SERVER没有值
    else 
    {
     // 如果getenv('HTTP_X_FORWARDED_FOR')非空取其值作为真实IP
        if (getenv('HTTP_X_FORWARDED_FOR'))
        {
            $realip = getenv('HTTP_X_FORWARDED_FOR');
        }
        // 如果getenv(''HTTP_CLIENT_IP'')非空取其值作为真实IP
        elseif (getenv('HTTP_CLIENT_IP'))
        {
            $realip = getenv('HTTP_CLIENT_IP');
        }
        // 否则取getenv(''REMOTE_ADDR'')的值作为真实IP
        else
        {
            $realip = getenv('REMOTE_ADDR');
        }
    }
    preg_match("/[\d\.]{7,15}/", $realip, $onlineip); 
    $realip = !empty($onlineip[0]) ? $onlineip[0] : '0.0.0.0'; 
    return $realip;
}
?>