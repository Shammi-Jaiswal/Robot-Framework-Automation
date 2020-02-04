*** Settings ***
Suite Setup       Open Application in Browser
Resource          ../Keywords/Generic.robot
Resource          ../Keywords/DELETE.robot
Resource          ../Keywords/TestCasesSetup.robot

*** Test Cases ***
USER DELETE A COMPUTER
    [Tags]    regression
    [Setup]    User is at Update Computer Page
    GIVEN EDIT COMPUTER PAGE IS DISPLAYED
    WHEN USER CLICKS ON DELETE BUTTON
    THEN COMPUTER SHOULD BE SUCCESSFULLY DELETED
