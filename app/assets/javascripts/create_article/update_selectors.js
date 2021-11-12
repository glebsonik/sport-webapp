async function getTranslatedTeams(languageName, conferenceId) {
    const translatedTeamsResponse = await fetch(`/api/v1/teams/teams?lang_key=${languageName}&conference_id=${conferenceId}`)
    const responseJson = await translatedTeamsResponse.json();

    return responseJson['error'] ? [] : responseJson
}
function getLanguageKey() {
    return document.cookie.split(';')
        .filter((item) => item.trim().startsWith('language='))[0]
        .split('=')[1]
}

function emptySelectWithFirstPrompt(selectEl) {
    for(let i = selectEl.options.length; i >= 1; i--){
        selectEl.options.remove(i);
    }
}

function addTeamsOptionsToSelect(selectEl, translatedTeams) {
    translatedTeams.forEach(team => {
        const option = document.createElement("option");
        option.text = team.name;
        option.value = team.id;
        selectEl.options.add(option);
    });
}

function styleIfNoValue(event) {
    if (event.target.value === '') {
        event.target.className += ' empty-select'
    } else {
        event.target.classList.remove("empty-select");
    }
}

function setDisableForElementsByIds(elementIds, isDisabled) {
    elementIds.forEach(elementId => {
        document.getElementById(elementId).disabled = isDisabled;
    });
}

window.addEventListener('load', () => {
    const selectsIds = ['conference_id', 'team_id', 'location_id']
    selectsIds.forEach(selectId => {
        document.getElementById(selectId).addEventListener('change', styleIfNoValue);
    });
    document.getElementById('conference_id').addEventListener('change',  async (event) => {
        const teamSelect = document.getElementById('team_id');

        emptySelectWithFirstPrompt(teamSelect);

        setDisableForElementsByIds(selectsIds, true);

        const translatedTeams = await getTranslatedTeams(getLanguageKey, event.target.value);

        addTeamsOptionsToSelect(teamSelect, translatedTeams);

        setDisableForElementsByIds(selectsIds, false);

        teamSelect.dispatchEvent(new Event('change'));
    })
});