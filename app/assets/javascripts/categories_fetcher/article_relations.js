async function getCategories() {
    console.log("Fetching data...");
    const response = await fetch('/api/v1/teams/teams?lang_key=en&conference_id=29');
    console.log("Fetching finished. Parsing....");
    const myJson = await response.json();

    console.log(myJson);
    return null;
}

document.addEventListener("DOMContentLoaded", () =>{
    let el = document.getElementById('amogus');
    el.addEventListener("click", getCategories);
});
