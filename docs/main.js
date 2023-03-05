"use strict";

function setHighlightRequired() {
	l = document.getElementsByClassName("required");
	r = false;
	for (var i = 0; i < l.length; i++) {
		val = l[i].children[1].value;
		text = l[i].children[0];
		if(val == "") {
			text.classList.add("highlight");
			r = true;
		} else {
			text.classList.remove("highlight");
		}
	}
	return r;
}

function generate() {
	const config = {
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

	if (setHighlightRequired()) {
		return;
	}
	
	let script = Object.entries(config)
		.filter(([_, value]) => value !== '')
		.map(([key, value]) => `export ${key}=${value}`)
		.join('');


	script += "curl -L -s https://raw.githubusercontent.com/miguelrcborges/archinstallscript/main/start.sh | sh";
	let d = document.createElement('a');
	d.style.display = 'none';
	d.setAttribute('download', "install.sh");
	d.setAttribute('href', 'data:application/x-sh;charset=utf-8,' + encodeURIComponent(script));
	document.body.appendChild(d);
	d.click();
	document.body.removeChild(d);
}