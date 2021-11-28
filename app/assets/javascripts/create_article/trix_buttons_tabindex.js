window.addEventListener('load', () => {
    [...document.querySelectorAll('trix-toolbar [type="button"]')].forEach(n => n.setAttribute('tabindex', '-1'));
});
