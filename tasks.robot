# ## Google Image Search Example
# This simple robot will execute a Google Image Search and save the first result image.
#
# In Robocorp Lab, click on the `>>` button above to run the whole example, or you can execute each cell by using the `>` button.

*** Settings ***
Documentation     Executes Google image search and stores the first result image.
Library           RPA.Browser
Library           RPA.Robocloud.Items

*** Variables ***
${GOOGLE_URL}     https://google.com/?hl=en
${SEARCH_TERM}    cute cat picture

*** Keywords ***
Accept Google Consent
    Select Frame     //iframe[contains(@src, "https://consent.google.com")]
    Click Element    id:introAgreeButton
    [Teardown]       Unselect frame

*** Keywords ***
Open Google search page
    Open Available Browser    ${GOOGLE_URL}
    Run Keyword And Ignore Error    Accept Google Consent

*** Keywords ***
Search for
    [Arguments]    ${text}
    Input Text    name:q    ${text}
    Press Keys    name:q    ENTER
    Wait Until Page Contains Element    search

*** Keywords ***
View image search results
    Click Link    Images

*** Keywords ***
Screenshot first result
    Capture Element Screenshot    css:div[data-ri="0"]    result.png
    Add Work Item File    result.png
    Save Work Item

*** Tasks ***
Execute Google image search and store the first result image
    Open Google search page
    Search for    ${SEARCH_TERM}
    View image search results
    Screenshot first result
    [Teardown]    Close Browser
