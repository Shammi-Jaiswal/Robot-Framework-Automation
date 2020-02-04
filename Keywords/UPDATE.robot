*** Settings ***
Library           Selenium2Library
Resource          Generic.robot
Resource          ../TestData/UPDATE.robot
Resource          ../TestObjects/UPDATE.robot
Library           ../Libraries/User_Defined_Library.py
Library           String

*** Keywords ***
USER CLICKS ON THE COMPUTER
    #Selecting the computer to be edited
    Run Keyword If    '${moreThanTenFound}'>'1'    Fail    Need to write a very complex mechanism to check that the Introductory date also matches, the discontinued date too matches and also company name matches as well in the same row
    Run Keyword If    '${moreThanTenFound}'=='1'    Run Keywords    Highlight Object    other    ${searchedComputerObj}
    ...    AND    Sleep    1s
    ...    AND    Execute Javascript    ${searchedComputerObj}.click();
    Log To Console    The Searched Computer Name is clicked

UPDATE COMPUTER PAGE IS DISPLAYED
    #Veify that the correct page is opened
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Edit computer    30s
    Run Keyword If    '${status}'=='True'    Log To Console    Update Computer Page is opened Successfully
    ...    ELSE    Fail    The Update Computer Page was not Launched

USER FILLS THE UPDATED INFORMATION
    Input Text    id=name    ${updatedComputerName}
    Highlight Object    id    name
    Input Text    id=introduced    ${updatedIntroducedDate}
    Highlight Object    id    introduced
    Input Text    id=discontinued    ${updatedDiscontinuedDate}
    Highlight Object    id    discontinued
    ${c}=    Get Element Count    xpath=//*[@id="company"]/option
    : FOR    ${a}    IN RANGE    1    ${c}
    \    ${paramJs}=    get_company_list_js    ${a}
    \    ${paramInnerText}=    Execute Javascript    ${paramJs}[0]
    \    ${paramValue}=    Execute Javascript    ${paramJs}[1]
    \    Exit For Loop If    '${paramInnerText}'=='${updatedCompanyName}'
    Select From List By Value    id=company    ${paramValue}
    Highlight Object    id    company
    Highlight Object    other    ${updateThisComputerObj}
    Log To Console    The computer details has been edited changes are as following:${\n}1.updatedComputerName="${updatedComputerName}"${\n}2.updatedIntroducedDate="${updatedIntroducedDate}"${\n}3.updatedDiscontinuedDate=${updatedDiscontinuedDate}${\n}4.updatedCompanyName=${paramValue}

CLICKS ON SAVE BUTTON
    Execute Javascript    ${updateThisComputerObj}.click();
    Log To Console    The computer details has been submitted

COMPUTER SHOULD BE SUCCESSFULLY UPDATED
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Add a new computer    30s
    Run Keyword If    '${status}'=='True'    Log To Console    ${\n}Home Page is opened Successfully after Updating a Computer
    ...    ELSE    Fail    ${\n}The Home Page was not Launched after updating a computer
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Computer ${updatedComputerName} has been updated
    Run Keyword If    '${status}'=='True'    Log To Console    Computer ${updatedComputerName} has been updated
