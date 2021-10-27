const showBlock = (id) => document.getElementById(id).style.display = 'flex';
const hideBlock = (id) => document.getElementById(id).style.display = 'none';

const addBlur = (id) => document.getElementById(id).style.filter = 'blur(2px)';
const removeBlur = (id) => document.getElementById(id).style.filter = 'blur(0px)';

function showObject(id) {
    const object = document.getElementById(id);
    object.style.visibility = 'visible';
    object.style.opacity = '1';
}

function hideObject(id) {
    const object = document.getElementById(id);
    object.style.visibility = 'hidden';
    object.style.opacity = '0';
}

function imageMouseEnter() {
    addBlur('img-preview');
    showObject('img-preview-toolbar');
}

function imageMouseLeave() {
    removeBlur('img-preview');
    hideObject('img-preview-toolbar');
}

function addRemoveImageEvent() {
    document.getElementById('delete-preview-image').addEventListener('click', (e) => {
        showBlock('img-placeholder');
        hideBlock('img-preview-section');
        document.getElementById('article-image').value = '';
    });
}

function addHoverEffect() {
    const imgPreview = document.getElementById('img-preview-section');
    imgPreview.addEventListener('mouseenter', imageMouseEnter);
    imgPreview.addEventListener('mouseleave', imageMouseLeave);
}

function setDragAndDropImageBehaviour() {
    const imgPlaceholder = document.getElementById('img-placeholder');
    imgPlaceholder.addEventListener("dragenter", dragEnter, );
    imgPlaceholder.addEventListener("dragover", preventDragDefault);
    imgPlaceholder.addEventListener("dragleave", dragExit);
    imgPlaceholder.addEventListener("drop", drop);
}

function preventDragDefault(e) {
    e.stopPropagation();
    e.preventDefault();
}

function dragEnter(e) {
    preventDragDefault(e);
    document.getElementById('img-placeholder').className += ' file-dragged';
}

function dragExit(e) {
    preventDragDefault(e);

    if (e.fromElement.className && e.fromElement.classList.contains('create-article-form')) {
        document.getElementById('img-placeholder').classList.remove('file-dragged');
    }
}

function drop(e) {
    preventDragDefault(e);

    const articleImage = document.getElementById('article-image')
    articleImage.files = e.dataTransfer.files;
    articleImage.dispatchEvent(new Event('change'));
    document.getElementById('img-placeholder').classList.remove('file-dragged');
}

window.addEventListener('load', () => {
    addRemoveImageEvent();
    addHoverEffect();

    document.getElementById('article-image').addEventListener('change', function(e) {
        if (this.files[0]) {
            const imgPreview = document.getElementById('img-preview');

            imgPreview.onload = () => URL.revokeObjectURL(imgPreview.src);
            imgPreview.style.backgroundImage = `url(${URL.createObjectURL(this.files[0])})`;

            hideObject('img-preview-toolbar');
            hideBlock('img-placeholder');
            showBlock('img-preview-section');
        }
    });
    setDragAndDropImageBehaviour();
});