*** Settings ***
Resource          Generic.robot
Library           Selenium2Library
Resource          ../TestData/Generic.robot

*** Keywords ***
Open Application in Browser
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Log To Console    Browser is opened and maximized

Highlight Object
    [Arguments]    ${objType}    ${objValue}
    Sleep    1s
    ${obj}=    Run Keyword If    '${objType}'=='id'    Set Variable    window.document.getElementById("${objValue}")
    ...    ELSE IF    '${objType}'=='other'    Set Variable    ${objValue}
    Execute Javascript    ${obj}.style.border="solid #FF0000"
    Sleep    1s
    Execute Javascript    ${obj}.style.border=""
    Sleep    1s

Get number of computers before deletion
    [Arguments]    ${numberOfComputerObj}
    #Get the Number of Computers Already present
    ${numberOfComputer}=    Execute Javascript    ${numberOfComputerObj}
    ${words}=    Split String    ${numberOfComputer}    ${SPACE}
    Log To Console    Number of Computer before adding = ${words}[0]
    ${numberOfComputerBeforeDeletion}=    Convert To Integer    ${words}[0]
    Set Global Variable    ${numberOfComputerBeforeDeletion}
