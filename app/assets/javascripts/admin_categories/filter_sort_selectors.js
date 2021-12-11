window.addEventListener('load', () => {
    ['conference', 'team', 'published'].forEach(selectId => {
        document.getElementById(selectId).addEventListener('change', (event)=>{
            const destinationURL = new URL(window.location.href);
            destinationURL.searchParams.set(selectId, event.target.value);
            window.location.href = destinationURL.toString();
        });
    } )
});