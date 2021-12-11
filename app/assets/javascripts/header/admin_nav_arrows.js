const ACTIVE_ARROW_COLOR = '#E02232';
const DISABLED_ARROW_COLOR = '#B2B2B2';

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function scrollAdminNav(isBackwards, navElement, leftArrow, rightArrow) {
    const directionValue = isBackwards ? -1 : 1;
    const scrollOffset = navElement.clientWidth;

    navElement.scrollBy({left: scrollOffset * directionValue, behavior: 'smooth'});
    await sleep(1000);

    updateLeftArrow(navElement, leftArrow)
    updateRightArrow(navElement, rightArrow)
}

function updateRightArrow(navElement, button) {
    const currentScrollPosition = navElement.scrollLeft + navElement.clientWidth;
    if (currentScrollPosition >= navElement.scrollWidth) {
        button.style.fill = DISABLED_ARROW_COLOR;
    } else {
        button.style.fill = ACTIVE_ARROW_COLOR;
    }
}

function updateLeftArrow(navElement, button) {
    if (navElement.scrollLeft > 0) {
        button.style.fill = ACTIVE_ARROW_COLOR;
    } else {
        button.style.fill = DISABLED_ARROW_COLOR;
    }
}

window.addEventListener('load', () => {
    const leftArrow = document.getElementsByClassName('arrow-left')[0];
    const rightArrow = document.getElementsByClassName('arrow-right')[0];
    const navMenu = document.getElementsByClassName('admin-nav-categories')[0];
    leftArrow.addEventListener('click', (e) => {
        scrollAdminNav(true, navMenu, leftArrow, rightArrow);
    });

    rightArrow.addEventListener('click', (e) => {
        scrollAdminNav(false, navMenu, leftArrow, rightArrow);
    });

    updateLeftArrow(navMenu, leftArrow);
    updateRightArrow(navMenu, rightArrow);
});