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
    popup.style.top = event.target.getBoundingClientRect().top + window.scrollY;
    popup.style.display = 'block';
}

function showBackground(background) {
    background.style.height = document.body.scrollHeight;
    background.style.display = 'block';
}

function getLanguageKey() {
    return document.cookie.split(';')
        .filter((item) => item.trim().startsWith('language='))[0]
        .split('=')[1]
}

async function loadAndRenderArticles(articlesContainer, popupElements, isInit = false) {
    if ((document.body.scrollTop + document.body.clientHeight >= document.body.scrollHeight)
        && (articlesContainer.getAttribute('last-loaded') !== 'true')
        && (articlesContainer.getAttribute('loading') !== 'true')) {

        articlesContainer.setAttribute('loading', 'true');

        const pageToLoad = isInit ? 0 : +articlesContainer.getAttribute('page') + 1;
        const category = articlesContainer.getAttribute('category');

        const resultJson = await getArticles(category, pageToLoad);
        if (resultJson.last) {
            articlesContainer.setAttribute('last-loaded', 'true');
            document.getElementById('load-more-button').style.display = 'none';
        }

        articlesContainer.setAttribute('page', pageToLoad);
        articlesContainer.insertAdjacentHTML('beforeend', resultJson.articles);
        addContextOptionsEventHandler(resultJson.count, popupElements);
        articlesContainer.removeAttribute('loading');
    }
}

async function getArticles(category, page) {
    const destinationURL = new URL(window.location.href);
    destinationURL.pathname = `/api/v1/admin_categories/${category}/articles`;
    destinationURL.searchParams.set('page', page);
    destinationURL.searchParams.set('language_key', getLanguageKey());

    return (await fetch(destinationURL.toString())).json();
}

function addContextOptionsEventHandler(lastArticlesCount, popupElements) {
    const cssQuery = `.article-tile:nth-last-child(-n+${lastArticlesCount}) .tile-opts`;

    [...document.querySelectorAll(cssQuery)].forEach(tileOptsBtn => {
        tileOptsBtn.addEventListener('click', (e) => {
            showContextOptions(e, popupElements.background, popupElements.popup);
        });
    });
}

window.addEventListener('load', async () => {
    const popupBackground = document.getElementById('popup-outer');
    const popup = document.getElementById('options-popup');
    const popupElements = {'popup': popup, 'background': popupBackground};
    const dataElement = document.getElementById('article-tiles-container');

    popupBackground.addEventListener('click', (e) => {
        e.target.style.display = 'none';
        popup.style.display = 'none';
    });

    await loadAndRenderArticles(dataElement, popupElements, true);

    document.addEventListener('scroll', async e => {
        await loadAndRenderArticles(dataElement, popupElements);
    });

    document.getElementById('load-more-button').addEventListener('click', async e => {
        await loadAndRenderArticles(dataElement, popupElements);
    });
});