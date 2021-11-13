function showContextOptions(event, background, popup) {
    showBackground(background);
    showPopup(event, popup);
}

function showPopup(event, popup) {
    popup.style.left = event.x + 5;
    popup.style.top = event.target.getBoundingClientRect().top;
    popup.style.display = 'block';
}

function showBackground(background) {
    console.log('Show backgr');
    background.style.display = 'block';
}

window.addEventListener('load', () => {
    const popupBackground = document.getElementById('popup-outer');
    const popup = document.getElementById('options-popup');

    popupBackground.addEventListener('click', (e) => {
        e.target.style.display = 'none';
        popup.style.display = 'none';
    });

    [...document.getElementsByClassName('tile-opts')].forEach(tileOptsBtn => {
        tileOptsBtn.addEventListener('click', (e) => {
            showContextOptions(e, popupBackground, popup)
        });
    });

});