function getLanguageKey() {
    return document.cookie.split(';')
        .filter((item) => item.trim().startsWith('language='))[0]
        .split('=')[1]
}

async function loadAndRenderArticles(articlesContainer, loadMoreButton) {
    const scrollElement = document.documentElement;
    if ((scrollElement.scrollTop + scrollElement.clientHeight >= scrollElement.scrollHeight)
        && (articlesContainer.getAttribute('last-loaded') !== 'true')
        && (articlesContainer.getAttribute('loading') !== 'true'))
    {
        const pageToLoad = +articlesContainer.getAttribute('page') + 1;
        const articlesResponse = await getArticles(pageToLoad);


        if (articlesResponse.last) {
            articlesContainer.setAttribute('last-loaded', 'true');
            if (loadMoreButton)
                loadMoreButton.style.display = 'none';
        }

        articlesContainer.setAttribute('page', pageToLoad);
        articlesContainer.insertAdjacentHTML('beforeend', articlesResponse.articles);
        articlesContainer.removeAttribute('loading');
    }
}

async function getArticles(page) {
    const articlesURL = (new URL(window.location.href));
    const navigationPath = articlesURL.pathname.split('user_categories/')[1];

    articlesURL.pathname = `/api/v1/user_categories/${navigationPath}`;
    articlesURL.searchParams.set('page', page);
    articlesURL.searchParams.set('language_key', getLanguageKey());

    return (await fetch(articlesURL.toString())).json();
}

window.addEventListener('load', async () => {
    const articlesListElement = document.getElementById('articles-list');
    const loadMoreButton = document.getElementById('load-more-button')
    document.addEventListener('scroll', async e => {
        await loadAndRenderArticles(articlesListElement, loadMoreButton);
    });

    if (loadMoreButton) {
        loadMoreButton.addEventListener('click', async e => {
            await loadAndRenderArticles(articlesListElement);
        });
    }
});
