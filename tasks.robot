*** Settings ***
Documentation       Executes Google image search and stores the first result image.

Library             RPA.Browser.Selenium
Library             RPA.Robocorp.WorkItems


*** Variables ***
${GOOGLE_URL}       https://google.com/?hl=en
${SEARCH_TERM}      cute cat picture


*** Tasks ***
Execute Google image search and store the first result image
    Open Google search page
    Search for    ${SEARCH_TERM}
    View image search results
    Screenshot first result
    [Teardown]    Close Browser


*** Keywords ***
Accept Google Consent
    Click Element    xpath://button/div[contains(text(), 'I agree')]

Open Google search page
    Open Available Browser    ${GOOGLE_URL}
    Run Keyword And Ignore Error    Accept Google Consent

Search for
    [Arguments]    ${text}
    Input Text    name:q    ${text}
    Press Keys    name:q    ENTER
    Wait Until Page Contains Element    search

View image search results
    Click Link    Images

Screenshot first result
    Capture Element Screenshot    css:div[data-ri="0"]    ${OUTPUT_DIR}/result.png
    Add Work Item File    ${OUTPUT_DIR}/result.png
    Save Work Item
