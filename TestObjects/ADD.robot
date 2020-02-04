*** Variables ***
${createThisComputerObj}    window.document.getElementsByClassName("btn primary")[0]
${companySelectorObj}    return window.document.getElementById("company").querySelectorAll("option")
${numberOfComputerObj}    return window.document.getElementsByTagName("h1")[1].innerText
