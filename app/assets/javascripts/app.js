//Scroll
const img = document.querySelectorAll('.move')
const navLi = document.querySelectorAll('.nav-item')
const menu = document.querySelector('.navbar-collapse')

//Scroll
img.forEach((cadaImg, i)=>{
    window.addEventListener('scroll', function () {
        var alturaVentana = window.innerHeight;
        var posicionObj = cadaImg.getBoundingClientRect().top;

        if ( posicionObj <  alturaVentana / 1.8) {
            cadaImg.classList.add('aparece');
        }
    });
})

// Arreglo Menu
navLi.forEach((cadaLi, i)=>{
    cadaLi.addEventListener('click', function(){
        menu.classList.remove('show')
    })
})
