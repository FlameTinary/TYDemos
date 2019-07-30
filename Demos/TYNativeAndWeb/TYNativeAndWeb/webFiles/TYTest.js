// js 中的方法
function buttonClick() {
    alert("hello");
}

// JS中的对象
function jsObject() {
    var person = {
        name : "Sheldon",
        age : 29,
        id : 9527
    };
    alert(person.name);
}

// 带有参数的函数
function changeDemo(text) {
    document.getElementById("Demo").innerHTML = text;
}

// 带有返回值的方法
function returnFunc(text) {
    return text + "哈哈";
}

function jsToOcFunction1()
{
    window.webkit.messageHandlers.jsToOcNoPrams.postMessage({});
}

function jsToOcFunction2()
{
    window.webkit.messageHandlers.jsToOcWithPrams.postMessage({"params1":"我是参数1","params2":"我是参数2"});
}

function showAlert()
{
    alert("被OC截获到了");
}

//图片点击事件
function clickImage()
{
    alert("欢迎你关注我！点击了图片");
}

//OC调用JS改变背景色
function changeColor()
{
    document.body.style.backgroundColor = randomColor();
}

//随机生成颜色
function randomColor()
{
    var r=Math.floor(Math.random()*256);
    var g=Math.floor(Math.random()*256);
    var b=Math.floor(Math.random()*256);
    return "rgb("+r+','+g+','+b+")";//所有方法的拼接都可以用ES6新特性`其他字符串{$变量名}`替换
}

// 切换图片
function changePicture(id, path) {
    var image = document.getElementById(id);
    image.src = path;
}