*** Settings ***
Library           Selenium2Library
Resource          Generic.robot
Resource          ../TestData/SEARCH.robot
Resource          ../TestData/UPDATE.robot
Resource          ../TestObjects/SEARCH.robot
Library           ../Libraries/User_Defined_Library.py
Library           String

*** Keywords ***
THE APPLICATION HOME PAGE IS DISPLAYED
    #Veify that the correct page is opened
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Add a new computer    30s
    Run Keyword If    '${status}'=='True'    Log To Console    ${\n}Home Page is opened Successfully
    ...    ELSE    Fail    ${\n}The Home Page was not Launched

USER SEARCH FOR THE COMPUTER NAME
    #Search for a different computer name
    ${searchTC}=    Run Keyword And Return Status    Should Contain    ${SUITE NAME}    SEARCH
    ${updateTC}=    Run Keyword And Return Status    Should Contain    ${SUITE NAME}    UPDATE
    ${deleteTC}=    Run Keyword And Return Status    Should Contain    ${SUITE NAME}    DELETE
    Run Keyword If    '${searchTC}'=='True'    Run Keywords    Input Text    id=searchbox    ${searchName}
    ...    AND    Log To Console    The computer name to be searched is "${searchName}" filled
    Run Keyword If    '${updateTC}'=='True'    Run Keywords    Input Text    id=searchbox    ${updateName}
    ...    AND    Log To Console    The computer name to be updated is "${updateName}" filled
    Run Keyword If    '${deleteTC}'=='True'    Run Keywords    Get number of computers before deletion    ${numberOfComputerObj}
    ...    AND    Input Text    id=searchbox    ${updatedComputerName}
    ...    AND    Log To Console    The computer name to be deleted is "${updatedComputerName}" filled
    Highlight Object    id    searchbox
    Highlight Object    id    searchsubmit
    Click Element    id=searchsubmit
    Log To Console    The search computer button is clicked
    ${numberOfComputer}=    Execute Javascript    ${numberOfComputerFoundObj}
    ${words}=    Split String    ${numberOfComputer}    ${SPACE}
    ${moreThanTenFound}=    Run Keyword If    '${words}[0]'=='One'    Set Variable    1
    ...    ELSE IF    '${words}[0]'=='No'    Set Variable    0
    ...    ELSE IF    '${words}[0]'!='One'    Set Variable    ${words}[0]
    ${moreThanTenFound}    Convert To Integer    ${moreThanTenFound}
    Log To Console    Number of Computer found = ${words}[0]
    ${flag}=    Set Variable    False
    ${flag}=    Run Keyword If    '${moreThanTenFound}'>'10'    Set Variable    True
    Set Global Variable    ${flag}
    Set Global Variable    ${moreThanTenFound}

COMPUTER NAME IS DISPLAYED IN SEARCH RESULT
    #Sort using Header columns
    Log To Console    User starts sorting columns
    Highlight Object    other    ${introducedColumnObj}
    Execute Javascript    ${introducedColumnObj}.click();
    Sleep    2s
    Highlight Object    other    ${introducedColumnObj}
    Execute Javascript    ${introducedColumnObj}.click();
    Sleep    2s
    Highlight Object    other    ${companyColumnObj}
    Execute Javascript    ${companyColumnObj}.click();
    Sleep    2s
    Highlight Object    other    ${companyColumnObj}
    Execute Javascript    ${companyColumnObj}.click();
    Sleep    2s
    Highlight Object    other    ${discontinuedColumnObj}
    Execute Javascript    ${discontinuedColumnObj}.click();
    Sleep    2s
    Highlight Object    other    ${discontinuedColumnObj}
    Execute Javascript    ${discontinuedColumnObj}.click();
    Sleep    2s
    Highlight Object    other    ${computerNameColumnObj}
    Execute Javascript    ${computerNameColumnObj}.click();
    Sleep    2s
    #Executed page navigation in search result if result found is more than 10
    Run Keyword If    '${flag}'=='True'    Navigate between Search Result Pages
    Run Keyword Unless    '${flag}'=='True'    Log To Console    Only one page displayed for the searched computer

Navigate between Search Result Pages
    Log To Console    More than one page is displayed for the searched computer name
    ${noOfPages}=    get_the_number_of_pages    ${moreThanTenFound}
    : FOR    ${i}    IN RANGE    1    ${noOfPages}
    \    Highlight Object    other    ${nextObj}
    \    Execute Javascript    ${nextObj}.click();
    \    Sleep    2s
    \    Log To Console    Navigated to ${i} Next Page
    : FOR    ${i}    IN RANGE    1    ${noOfPages}
    \    Highlight Object    other    ${prevObj}
    \    Execute Javascript    ${prevObj}.click();
    \    Sleep    2s
    \    Log To Console    Navigated to ${i} Prev Page
