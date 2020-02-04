*** Settings ***
Library           Selenium2Library
Resource          Generic.robot
Resource          ../TestObjects/DELETE.robot
Library           ../Libraries/User_Defined_Library.py
Library           String

*** Keywords ***
EDIT COMPUTER PAGE IS DISPLAYED
    #Veify that the correct page is opened
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Edit computer    30s
    Run Keyword If    '${status}'=='True'    Log To Console    Edit Computer Page is opened Successfully
    ...    ELSE    Fail    The Edit Computer Page was not Launched

USER CLICKS ON DELETE BUTTON
    Highlight Object    other    ${deleteThisComputerObj}
    Execute Javascript    ${deleteThisComputerObj}.click();
    Log To Console    The computer delete button is clicked

COMPUTER SHOULD BE SUCCESSFULLY DELETED
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Add a new computer    30s
    Run Keyword If    '${status}'=='True'    Log To Console    ${\n}Home Page is opened Successfully after Deleting a Computer
    ...    ELSE    Fail    ${\n}The Home Page was not Launched after deleting a computer
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Computer has been deleted
    Run Keyword If    '${status}'=='True'    Log To Console    Computer has been deleted
    ${numberOfComputer}=    Execute Javascript    ${numberOfComputerObj}
    ${words}=    Split String    ${numberOfComputer}    ${SPACE}
    Log To Console    Number of Computer after adding = ${words}[0]
    ${numberOfComputerAfterDeletion}=    Convert To Integer    ${words}[0]
    ${numberOfComputerAfterDeletion}=    Evaluate    ${numberOfComputerAfterDeletion}+1
    Run Keyword If    '${numberOfComputerAfterDeletion}'=='${numberOfComputerBeforeDeletion}'    Log To Console    The Count of Computer is decreased by One
    Run Keyword Unless    '${numberOfComputerAfterDeletion}'=='${numberOfComputerBeforeDeletion}'    Fail    It Failed to decrease the count even the computer is deleted
