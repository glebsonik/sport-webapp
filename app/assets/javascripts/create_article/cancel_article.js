function confirmModalEvent() {
    location.href = document.getElementById('cancel-article-btn').getAttribute('data-value');
}

function showModal(modal) {
    modal.style.display = 'block';
}

function hideModal(modal) {
    modal.style.display = 'none';
}

window.addEventListener('load', () => {
    const modal = document.getElementById('cancel-article-modal');
    const modalOuterSpace = document.getElementById('cancel-modal-outer');
    modalOuterSpace.addEventListener('click', (e) => {
        if (e.target === modalOuterSpace)
            hideModal(modal);
    });

    document.getElementById('cancel-article-btn').addEventListener('click', (e) => {
        showModal(modal);
    });

    document.getElementById('cancel-modal-confirm').addEventListener('click', (e)=> {
        confirmModalEvent();
    });

    document.getElementById('cancel-modal-cancel').addEventListener('click', (e) => {
        hideModal(modal)});
});