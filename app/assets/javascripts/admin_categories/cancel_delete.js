function showDeleteModal() {
    showModal();
}

function hideModalAndOptions() {
    document.getElementById('delete-article-modal').style.display = 'none';
    document.getElementById('options-popup').style.display = 'none';
    document.getElementById('popup-outer').style.display = 'none';
}

function showModal() {
    document.getElementById('delete-article-modal').style.display = 'block';
}

function modalApply() {
    document.getElementById('delete').click();
}

window.addEventListener('load', () => {
    const modalOuterSpace = document.getElementById('delete-modal-outer');
    modalOuterSpace.addEventListener('click', (e) => {
        if (e.target === modalOuterSpace) {
            hideModalAndOptions();
        }
    });
    document.getElementById('delete-modal-cancel').addEventListener('click', hideModalAndOptions);
    document.getElementById('show-modal-delete').addEventListener('click', showDeleteModal)
    document.getElementById('delete-modal-confirm').addEventListener('click', modalApply);
});