function setHighlightRequired(color) {
    l = document.getElementsByClassName("required")
    r = false
    for (var i = 0; i < l.length; i++) {
        val = l[i].children[1].value
        text = l[i].children[0]
        if(val == "") {
            text.style.color=color
            text.style.fontWeight="bold"
            r = true
        } else {
            text.style.color=""
            text.style.fontWeight=""
        }
    }
    return r
}

function generate() {
    var config = {
    "root": document.getElementById("root").value,
    "boot": document.getElementById("boot").value,
    "swap": document.getElementById("swap").value,
    "home": document.getElementById("home").value,
    "winefi": document.getElementById("winefi").value,
    "kernel": document.getElementById("kernel").value,
    "network": document.getElementById("network").value,
    "installtype": document.getElementById("installtype").value,
    "desktop": document.getElementById("desktop").value,
    "hostname": document.getElementById("host").value,
    "timezone": document.getElementById("timezone").value,
    "gpu": document.getElementById("gpu").value,
    "username": document.getElementById("user").value,
    "userpw": document.getElementById("userpw").value,
    "rootpw": document.getElementById("rootpw").value,
    "editor": document.getElementById("editor").value,
}
    if(setHighlightRequired("red")) {
        return
    }
    let script = ""
    Object.entries(config).forEach(([k,v]) => {
        if (v != "") {
            script += "export " + k + "=" + v + ";"
        }
    })
    script += "curl -L -s https://bit.ly/35SjPVH | sh"
    document.getElementsByClassName("script")[0].innerHTML = script
}