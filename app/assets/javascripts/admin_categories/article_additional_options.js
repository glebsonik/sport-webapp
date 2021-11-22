function showContextOptions(event, background, popup) {
    showBackground(background);
    showPopup(event, popup);
    preparePopupInfo(event.target);
}

function preparePopupInfo(infoElement) {
    const publishLink = document.getElementById('publish');
    const unpublishLink = document.getElementById('unpublish');
    if (infoElement.getAttribute('published') === 'true') {
        publishLink.style.display = 'none';
        unpublishLink.style.display = 'block';
        unpublishLink.href = infoElement.getAttribute('unpublish_url');
    } else {
        publishLink.style.display = 'block';
        publishLink.href = infoElement.getAttribute('publish_url');
        unpublishLink.style.display = 'none';
    }
    const deleteLink = document.getElementById('delete');
    deleteLink.href = infoElement.getAttribute('delete_url');
}

function showPopup(event, popup) {
    popup.style.left = event.x + 5;
    popup.style.top = event.target.getBoundingClientRect().top;
    popup.style.display = 'block';
}

function showBackground(background) {
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