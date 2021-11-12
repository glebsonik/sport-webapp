// WIP
function addLoader(parentElement) {
    let el = document.createElement('div');
    el.style.position += 'absolute'
    el.className += 'loader';
    el.id = 'spinner';
    parentElement.insertAdjacentElement('afterbegin', el);
}

function removeLoader() {
    document.getElementById('spinner').remove();
}