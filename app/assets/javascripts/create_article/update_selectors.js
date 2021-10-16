async function getTranslatedTeams(language_name, conferenceId) {
    const translatedTeamsResponse = await fetch(`/api/v1/teams/teams?lang_key=${language_name}&conference_id=${conferenceId}`)
    return translatedTeamsResponse.json();
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
        option.value = team.team_id;
        selectEl.options.add(option);
    });
}

function styleIfNoValue(event) {
    if (event.target.value === '') {
        event.target.className += ' emptySelect'
    } else {
        event.target.classList.remove("emptySelect");
    }
}

function setDisableForElementsByIds(elementIds, isDisabled) {
    elementIds.forEach(elementId => {
        document.getElementById(elementId).disabled = isDisabled;
    });
}

window.addEventListener('load', () => {
    const selectsIds = ['conference-select', 'team-select', 'location-select']
    selectsIds.forEach(selectId => {
        document.getElementById(selectId).addEventListener('change', styleIfNoValue);
    });
    document.getElementById('conference-select').addEventListener('change',  async (event) => {
        const teamSelect = document.getElementById('team-select');

        emptySelectWithFirstPrompt(teamSelect);

        setDisableForElementsByIds(selectsIds, true);

        const conferenceId = event.target.value
        const translatedTeams = await getTranslatedTeams(getLanguageKey, conferenceId);

        addTeamsOptionsToSelect(teamSelect, translatedTeams);

        setDisableForElementsByIds(selectsIds, false);

        teamSelect.dispatchEvent(new Event('change'));
    })
});