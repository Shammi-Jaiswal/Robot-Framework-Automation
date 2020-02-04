*** Settings ***
Resource          Generic.robot
Resource          ADD.robot
Resource          SEARCH.robot
Resource          UPDATE.robot

*** Keywords ***
User is at Add Computer Page
    GIVEN ADD.THE APPLICATION HOME PAGE IS DISPLAYED
    WHEN ADD A NEW COMPUTER BUTTON IS CLICKED

The computer name is found
    GIVEN SEARCH.THE APPLICATION HOME PAGE IS DISPLAYED
    WHEN USER SEARCH FOR THE COMPUTER NAME

User is at Update Computer Page
    GIVEN THE COMPUTER NAME IS FOUND
    WHEN USER CLICKS ON THE COMPUTER
