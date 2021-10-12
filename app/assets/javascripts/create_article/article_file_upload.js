function deletePreviewImage() {
    const placeholder = document.getElementsByClassName('article-placeholder')[0];
    placeholder.style.display = 'flex';
    document.getElementById('img-preview-section').style.display = 'none';
    document.getElementById('file-input').value = '';
    document.getElementById('file-input').type = 'text';
    document.getElementById('file-input').type = 'file';
}

function hidePlaceholder() {
    const placeholder = document.getElementsByClassName('article-placeholder')[0];
    placeholder.style.display = 'none';
}

function imageMouseEnter() {
    document.getElementById('img-preview').style.filter = 'blur(2px)';
    showToolbar();
}

function showToolbar() {
    const toolbar = document.getElementById('img-preview-toolbar');
    toolbar.style.visibility = 'visible';
    toolbar.style.opacity = '1';
}

function imageMouseLeave() {
    document.getElementById('img-preview').style.filter = 'blur(0px)';
    hideToolbar();
}

function hideToolbar() {
    const toolbar = document.getElementById('img-preview-toolbar');
    toolbar.style.visibility = 'hidden';
    toolbar.style.opacity = '0';
}

function setDeleteButton() {
    const deletePreviewButton = document.getElementById('delete-preview-image')
    deletePreviewButton.addEventListener('click', deletePreviewImage);
    deletePreviewButton.style.filter = 'blur(0px)';
}

window.addEventListener('load', function() {
    setDeleteButton();
    document.getElementById('file-input').addEventListener('change', function() {
        if (this.files[0]) {
            console.log("==== There is a file change ====");
            const imgPreview = document.getElementById('img-preview');
            imgPreview.onload = () => {
                URL.revokeObjectURL(imgPreview.src);
            }
            imgPreview.style.backgroundImage = `url(${URL.createObjectURL(this.files[0])})`;

            const eventRegister = document.getElementById('img-preview-section');
            eventRegister.addEventListener('mousemove', imageMouseEnter)
            eventRegister.addEventListener('mouseleave', imageMouseLeave);
            hideToolbar();
            hidePlaceholder();
            document.getElementById('img-preview-section').style.display = 'flex';
        }
    });
});