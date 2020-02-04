*** Settings ***
Suite Setup       Open Application in Browser
Resource          ../Keywords/Generic.robot
Resource          ../Keywords/UPDATE.robot
Resource          ../Keywords/TestCasesSetup.robot

*** Test Cases ***
USER NAVIGATES TO UPDATE COMPUTER PAGE
    GIVEN THE COMPUTER NAME IS FOUND
    WHEN USER CLICKS ON THE COMPUTER
    THEN UPDATE COMPUTER PAGE IS DISPLAYED

USER UPDATE A NEW COMPUTER
    [Tags]    regression
    [Setup]    User is at Update Computer Page
    GIVEN UPDATE COMPUTER PAGE IS DISPLAYED
    WHEN USER FILLS THE UPDATED INFORMATION
    AND CLICKS ON SAVE BUTTON
    THEN COMPUTER SHOULD BE SUCCESSFULLY UPDATED
