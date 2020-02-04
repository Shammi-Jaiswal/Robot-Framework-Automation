*** Settings ***
Library           Selenium2Library
Resource          Generic.robot
Resource          TestCasesSetup.robot
Resource          ../TestData/ADD.robot
Resource          ../TestObjects/ADD.robot
Library           ../Libraries/User_Defined_Library.py
Library           String

*** Keywords ***
THE APPLICATION HOME PAGE IS DISPLAYED
    #Veify that the correct page is opened
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Add a new computer    30s
    Run Keyword If    '${status}'=='True'    Log To Console    ${\n}Home Page is opened Successfully
    ...    ELSE    Fail    ${\n}The Home Page was not Launched

ADD A NEW COMPUTER BUTTON IS CLICKED
    #Get the Number of Computers Already present
    ${numberOfComputer}=    Execute Javascript    ${numberOfComputerObj}
    ${words}=    Split String    ${numberOfComputer}    ${SPACE}
    Log To Console    Number of Computer before adding = ${words}[0]
    ${numberOfComputerBeforeAdding}=    Convert To Integer    ${words}[0]
    Set Global Variable    ${numberOfComputerBeforeAdding}
    #Click on the Add a New Computer button
    Highlight Object    id    add
    Click Element    id=add
    Log To Console    The Add a New Computer Button is clicked

ADD A COMPUTER PAGE IS DISPLAYED
    #Veify that the correct page is opened
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Add a computer    30s
    Run Keyword If    '${status}'=='True'    Log To Console    Add Computer Page is opened Successfully
    ...    ELSE    Fail    The Add Computer Page was not Launched

USER FILLS THE INFORMATION
    #Enter the Computer Information and Submit
    Input Text    id=name    ${computerName}
    Highlight Object    id    name
    Input Text    id=introduced    ${introducedDate}
    Highlight Object    id    introduced
    Input Text    id=discontinued    ${discontinuedDate}
    Highlight Object    id    discontinued
    ${c}=    Get Element Count    xpath=//*[@id="company"]/option
    : FOR    ${a}    IN RANGE    1    ${c}
    \    ${paramJs}=    get_company_list_js    ${a}
    \    ${paramInnerText}=    Execute Javascript    ${paramJs}[0]
    \    ${paramValue}=    Execute Javascript    ${paramJs}[1]
    \    Exit For Loop If    '${paramInnerText}'=='${companyName}'
    Select From List By Value    id=company    ${paramValue}
    Highlight Object    id    company
    Highlight Object    other    ${createThisComputerObj}
    Log To Console    The Computer Details to be added is filled

CLICKS ON SUBMIT BUTTON
    Execute Javascript    ${createThisComputerObj}.click();
    Log To Console    Create new computer has been clicked

COMPUTER SHOULD BE SUCCESSFULLY ADDED
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Add a new computer    30s
    Run Keyword If    '${status}'=='True'    Log To Console    ${\n}Home Page is opened Successfully after Creating a Computer
    ...    ELSE    Fail    ${\n}The Home Page was not Launched after creating a computer
    ${status}=    Run Keyword And Return Status    Wait Until Page Contains    Computer ${computerName} has been created
    Run Keyword If    '${status}'=='True'    Log To Console    Computer ${computerName} has been created
    ${numberOfComputer}=    Execute Javascript    ${numberOfComputerObj}
    ${words}=    Split String    ${numberOfComputer}    ${SPACE}
    Log To Console    Number of Computer after adding = ${words}[0]
    ${numberOfComputerAfterAdding}=    Convert To Integer    ${words}[0]
    ${numberOfComputerAfterAdding}=    Evaluate    ${numberOfComputerAfterAdding}-1
    Run Keyword If    '${numberOfComputerAfterAdding}'=='${numberOfComputerBeforeAdding}'    Log To Console    The Count of Computer is increased by One
    Run Keyword Unless    '${numberOfComputerAfterAdding}'=='${numberOfComputerBeforeAdding}'    Fail    It Failed to increase the count even the computer was added
