*** Settings ***
Suite Setup       Open Application in Browser
Resource          ../Keywords/Generic.robot
Resource          ../Keywords/ADD.robot

*** Test Cases ***
USER NAVIGATES TO ADD COMPUTER PAGE
    GIVEN ADD.THE APPLICATION HOME PAGE IS DISPLAYED
    WHEN ADD A NEW COMPUTER BUTTON IS CLICKED
    THEN ADD A COMPUTER PAGE IS DISPLAYED

USER CREATE A NEW COMPUTER
    [Tags]    regression
    [Setup]    User is at Add Computer Page
    GIVEN ADD A COMPUTER PAGE IS DISPLAYED
    WHEN USER FILLS THE INFORMATION
    AND CLICKS ON SUBMIT BUTTON
    THEN COMPUTER SHOULD BE SUCCESSFULLY ADDED
