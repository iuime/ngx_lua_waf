RulePath = "/usr/local/nginx/conf/waf/wafconf/"
attacklog = "on"
CCattacklog = "on" --CC攻击日志
logdir = "/usr/local/nginx/logs/hack/"
UrlDeny="on"
Redirect="on"
CookieMatch="on"
postMatch="on" 
whiteModule="on" 
black_fileExt={"php","jsp"}
ipWhitelist={"127.0.0.1"}
ipBlocklist={"1.0.0.1"}
CCDeny="on"
CCrate="100/60"
cchtml=[[
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>亲，访问太快了,请休息一下吧！</title>
</head>
<body>
<p>亲，访问太快了,请休息一下吧！</p>
</body>
</html>
]]
html=[[
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<style>
body{ background:#fff; font-family: microsoft yahei; color:#969696; font-size:14px;}
.online-desc-con { text-align:center; }
.r-tip01 { color: #333; font-size: 18px; display: block; text-align: center; width: 500px; padding: 0 10px; overflow: hidden; text-overflow: ellipsis; margin: 0 auto 15px; }
.r-tip02 { color: #585858; font-size: 14px; display: block; margin-top: 20px; margin-bottom: 20px; }
#notice-jiasule {
  word-wrap: break-word;
  word-break: normal;
  color:#585858;
  border:1px solid #ddd;
  padding:0px 20px 0px 20px
}
img { border: 0; }
.u-ico{ vertical-align: middle; margin-right: 12px;}
.btn{ padding: 8px 22px; border-radius: 3px; border: 0; display: inline-block;vertical-align: middle;text-decoration: none;}
.btn-g{ background-color: #61b25e; color: #fff;}
.report {color: #858585; text-decoration: none;}
.report:hover {text-decoration: underline; color: #0088CC;}
hr{ border-top: 1px dashed #ddd;}
center{ line-height: 48px; color: #919191;}
</style>
<script type="text/template" id="content_tpl">
    <span class="r-tip01"><%= error_403 %></span>
    <div id='notice-jiasule'>
        <p>当前网址：<%- url %></p>
        <p>客户端特征：<%- user_agent %></p>
        <p>拦截时间：<%- now %>&nbsp;&nbsp;</p>
    </div>
    <span class='r-tip02'>
        <img class='u-ico' alt='' src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB8AAAAfCAYAAAAfrhY5AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAABAhpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMDY3IDc5LjE1Nzc0NywgMjAxNS8wMy8zMC0yMzo0MDo0MiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ1dWlkOjlFM0U1QzlBOEM4MURCMTE4NzM0REI1OEZEREU0QkE3IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjFBRTgyMDdFMzlERjExRTc4RUNGODc1MTZFQzY2QTExIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjFBRTgyMDdEMzlERjExRTc4RUNGODc1MTZFQzY2QTExIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE3IChNYWNpbnRvc2gpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MjQxNjlhNjEtNmM3Yy00MDk2LWJjMGItNmNmNjcxMDBkNWUzIiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6ZTkzZmU0NDAtN2Y1Zi0xMTdhLTgxZjktZjU2N2FlZTNiYWYwIi8+IDxkYzp0aXRsZT4gPHJkZjpBbHQ+IDxyZGY6bGkgeG1sOmxhbmc9IngtZGVmYXVsdCI+5Z+65pysIFJHQjwvcmRmOmxpPiA8L3JkZjpBbHQ+IDwvZGM6dGl0bGU+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+gAX++AAAAwNJREFUeNq0l19IU3EUx8/dJrQyttU0UjBqm7r1EFFUhqkR0ov9oyx9CYKMeumt9C2I6KWH6KlIq9e0IDOfy5rNnJMW5EyhIArFzUjXZpvtT+dcfjfEdnfP9c+BD+Lu/X2/2+93fud3ftK5nrPAjEqkATmAeJAixILMIhEkhHiRXuQTR9Ck8VxCjiFXkSqVdywCJ3IUuYX4xN/nSFZN3JDHuALpQ57lMVaL/WLcK6Rcr3kjEkBqYHlRiwwLPZZ5C/IYKYSViUKh16Jlfga5p7EcSwnSuyv0c5rTGnesgrESRqFfsTjbKavbuVPt2uCCU+7T4LA5IZlOgn9iEJ6GuiD+J85ZgvtIHe0C5VceF/tXMxw2B1ypasMvUA4GyQBmkxlqy+rws1YwGUwciRrh92+K27hzd7KyMadJmWUL7Ctl78hWxZyq1R7uKCdOufpylHNl9iLbyfyInqyZT8+rPqP11xENZF6tZ0Rw6r3qsw9TQT1S1cq0s6Mr1AnhePi/z/u+voSRyEc9Uh7KnGI9I6LJWbjuvQaHttaDE7daIpWAwOQQDE349e77YpOeMipJEmw02+Wi8O67T0aJorVF8ppHk1F22SXzGPcLNHmaoX7bYdXnmWwGbr69AV9+fubIxWjNw+xuwu7OX8Cx6LhsLq5c2CA6EO2TAYU3F5ZovleyvpRrHiLzflZ2rNvEKp+lfPN+Mn/BeXMOD418BUaJ6d/TXPNeZdr92lssCnf8tyE2/0v1neHJADwKPuAYDyIjxp3NO+ifH4sP+py/ai4C3m9eKDAWyAcJ5YE8GH/tw2AH9Ix3Qzqb5phfpg5XEq0zbd3X3GOVwrrGCm67Rz7DQ5ERSGVS3KFvlPNcyaCs6LEC3D0/k5iBgQVFhhlUUy4o7fTClmkMOU+1YpXaqLTQH1NrIDuRi6vwBUjvktDP2zpTL9ckpmglIib02rmXhifIbpEcywlK4l1CT9d1aUxk5QlkQKepT4w7iIwv9aJIWdktWHhLdYtbqpUSX9xSR/XeUv8KMACb0NFXFbsqFwAAAABJRU5ErkJggg==" />如果您是网站管理员，请登录防火墙查看日志信息&nbsp;

    </span>
</script>
<script type="text/javascript" src="https://cdn.bootcss.com/underscore.js/1.8.3/underscore-min.js"></script>
</head>
<body>
<div class="online-desc-con" style="width:640px;padding-top:15px;margin:34px auto;">
	<img alt="" style="margin: 0 auto 17px auto;" src="data:image/png;base64,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" />
    <div id="content_rendered"></div>
	<hr />
	<center>client: {ip}, server: {host}, time: {time},</center>
</div>
<script>
void(function fuckie6(){if(location.hash && /MSIE 6/.test(navigator.userAgent) && !/jsl_sec/.test(location.href)){location.href = location.href.split('#')[0] + '&jsl_sec' + location.hash}})();
var content = _.template(document.getElementById('content_tpl').innerHTML)({
    error_403: '' || '当前访问疑似黑客攻击，已被网站管理员设置为拦截',
    url: document.URL.replace(/\</g,"%3C").replace(/\>/g,"%3E"),
    user_agent: navigator.userAgent,
    now: new Date(new Date() - -8 * 3600000).toISOString().substr(0, 19).replace('T', ' '),
    rule_id: parseInt('[30021]'.replace(/\[|\]/g, '')) || '',
    from: encodeURIComponent(document.referrer.substr(0, 1024)),
    client_ip: '',
    ref: encodeURIComponent(document.URL.substr(0, 1024))
});
document.getElementById('content_rendered').innerHTML = content;
</script>
<div style="display:none;">
</div>
</body>

</html>
]]
