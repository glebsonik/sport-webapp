async function showPreview() {
    updateNonContentBlocks();
    updateContent();
    updateImage();
    await smoothHideElement(document.getElementById('create-article-form'));
    document.getElementById('preview-main').style.display = 'block';
}

async function showArticle() {
    await smoothHideElement(document.getElementById('preview-main'));
    document.getElementById('create-article-form').style.display = 'block';
}

async function smoothHideElement(element, animationTime = 300) {
    element.style.transition = 'all 0.3s ease-in-out';
    element.style.opacity = 0;
    await sleep(animationTime);
    element.style.display = 'none';
    element.style.opacity = 1;
    element.style.transition = '';
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function updateNonContentBlocks() {
    updateBreadcrumbsFromSelectors();
    const ArticleToPreviewIds = {headline: 'preview-headline'}
    for (const form_id in ArticleToPreviewIds) {
        const valueElement = document.getElementById(form_id);
        if (elementValueNotEmpty(valueElement)) {
            document.getElementById(ArticleToPreviewIds[form_id]).textContent = valueElement.value;
        }
    }
}

function updateContent() {
    const articleContentEl = document.getElementById('article-content');
    if (elementValueNotEmpty(articleContentEl))
        document.getElementById('content').innerHTML = articleContentEl.value;
}

function updateBreadcrumbsFromSelectors() {
    const ArticleToPreviewIds = {conference_id: 'conference', team_id: 'team'}
    for (const form_id in ArticleToPreviewIds) {
        const valueElement = document.getElementById(form_id);
        if (elementValueNotEmpty(valueElement)) {
            document.getElementById(ArticleToPreviewIds[form_id]).textContent =
                valueElement.options[valueElement.selectedIndex].text;
        }
    }
}
function updateImage() {
    const imageInput = document.getElementById('article-image');
    if (imageInput.files.length === 0)
        return
    document.getElementById('article-preview-image').src = URL.createObjectURL(imageInput.files[0]);
}

function elementValueNotEmpty(element) {
    return (element.value && element.value.trim() !== '');
}

window.addEventListener('load', () => {
    document.getElementById('preview-link').addEventListener('click', showPreview);
    document.getElementById('show-article-link').addEventListener('click', showArticle);
});