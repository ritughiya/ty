getNewRandomColor();

function getNewRandomColor()
{
    var myArray = ['#c6d6db', '#DBE895', '#FFD1BC', '#ececec'];    
    var rand = myArray[Math.floor(Math.random() * myArray.length)];
    document.getElementById("html").style.backgroundColor = rand;
}