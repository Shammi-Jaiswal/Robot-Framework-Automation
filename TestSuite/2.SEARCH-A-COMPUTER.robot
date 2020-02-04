*** Settings ***
Suite Setup       Open Application in Browser
Resource          ../Keywords/Generic.robot
Resource          ../Keywords/SEARCH.robot

*** Test Cases ***
USER SEARCHES FOR THE COMPUTER NAME
    [Tags]    regression
    GIVEN THE APPLICATION HOME PAGE IS DISPLAYED
    WHEN USER SEARCH FOR THE COMPUTER NAME
    THEN COMPUTER NAME IS DISPLAYED IN SEARCH RESULT
