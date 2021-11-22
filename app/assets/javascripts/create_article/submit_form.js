function addModalEvents(modalId) {
    const modal = document.getElementById(modalId);
    const modalOuterSpace = document.getElementById('error-modal-outer');
    modalOuterSpace.addEventListener('click', () => {
        modal.style.display = "none";
    });

    const modalButton = document.getElementById('error-modal-confirm');
    modalButton.addEventListener('click', () => {
        modal.style.display = "none";
    });
}

function isFormValid() {
    let formValid = true
    getAllFields().forEach(field => {
        formValid = formValid && field.checkValidity();
    });
    return formValid;
}

function getAllFields() {
    return document.getElementsByClassName('create-article-form')[0]
        .querySelectorAll('input[id][required],select[required]');
}
function isValidImage(){
    return document.getElementById('article-image').checkValidity();
}

function showModalWithErrors(modalId, modalText) {
    const modal = document.getElementById(modalId);
    document.getElementById('error-modal-content').textContent = modalText;
    modal.style.display = 'block';
}

window.addEventListener('load', () => {
    const modalId = 'errors-in-form-modal';

    addModalEvents(modalId);

    document.getElementById('save-article').addEventListener('click', (e)=> {
        if (isFormValid()) {
            document.getElementById('submit-article-form').click();
        } else {
            let errorText = "";
            if (!isValidImage())
                errorText = "You need to attach image for your article";
            else
                errorText = "Please fill all your inputs";

            showModalWithErrors(modalId, errorText);
        }
    });
});