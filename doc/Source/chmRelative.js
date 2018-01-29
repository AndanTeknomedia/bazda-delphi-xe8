function relativelnk(a){var b,c;b=location.href.search(/:/)==2?14:7;c=location.href.lastIndexOf("\\")+1;a="file:///"+location.href.substring(b,c)+a;location.href=a};
function getElementsByClassName(classname, node)  {
    if(!node) node = document.getElementsByTagName("body")[0];
    var a = [];
    var re = new RegExp('\\b' + classname + '\\b');
    var els = node.getElementsByTagName("*");
    for(var i=0,j=els.length; i<j; i++)
        if(re.test(els[i].className))a.push(els[i]);
    return a;
}


function findWatermark(toFind){
	var aTags = document.getElementsByTagName("span");
	var found;

	for (var i = 0; i < aTags.length; i++) {
	  // if (aTags[i].textContent == searchText) {
	  if (aTags[i].innerHTML.toLowerCase().indexOf(toFind.toLowerCase())) {
		found = aTags[i];
		break; 
	  }
	}
	return found;
}

function hideByText(text, opts) {
    if (!text) {
        return false;
    }
    else {
        var defaults = {
            // the element we look within, expects:
            // 1: node reference, eg the result of: document.getElementsByTagName('div')[0]
            // 2: an element's id, as a string, eg: 'test'
            'within': document.body,
            // the element type, eg 'div', 'span', 'p', defaults to *everything*
            'elemType': '*',
            // case-sensitivity, as a string:
            // 'true' : is case sensitive, 'Some' will not match 'some',
            // 'false' : is case insensitive, 'Some' will match 'some'
            'sensitive': 'true',
            // 'absolute' : 'some text' will not match 'some text.'
            // 'partial' : 'some text' will match 'some text.'
            'match': 'absolute',
            // 'true' : removes white-space from beginning, and end, of the text,
            // 'false' : does not remove white-space
            'trim': 'true',
            // the class to add to elements if a match is made,
            // use CSS to hide, or style, the matched elements
            'matchedClass': /*'hasText'*/''
        },
            opts = opts || {};

        for (var setting in defaults) {
            if (defaults.hasOwnProperty(setting)) {
                opts[setting] = opts[setting] || defaults[setting];
            }
        }

        var within = opts.within.nodeType == 1 ? opts.within : document.getElementById(opts.within),
            elems = within.getElementsByTagName(opts.elemType),
            flags = opts.sensitive == 'true' ? 'i' : '',
            needle = opts.trim == 'true' ? text.replace(/^(\s+) || (\s+)$/g, '') : text,
            haystack,
            reg = new RegExp(needle, flags);
        
        if (opts.match == 'absolute') {
            for (var i = 0, len = elems.length; i < len; i++) {
                if ((elems[i].textContent || elems[i].innerText) == text) {
                    // elems[i].className = opts.matchedClass;
					elems[i].style.display = "none";
                }
            }
        }
        else if (opts.match == 'partial') {
            for (var i = 0, len = elems.length; i < len; i++) {
                if ((elems[i].textContent || elems[i].innerText).match(reg)) {
                    // elems[i].className = opts.matchedClass;
					elems[i].style.display = "none";
                }
            }
        }
    }
}



function load(){
	// alert ('rvps4');
	var elements = new Array();
	elements = getElementsByClassName('rvps4');
	for(i in elements ){
		 elements[i].style.display = "none";
	}
}

function load2()
{
	var tag = findWatermark('Created with the Personal Edition');
	alert(tag);
	if (tag){
		tag.style.display = 'none';
	}
}



window.onload = function () {
	hideByText('Created with the Personal Edition', {
		'match': 'partial',
		'sensitive': 'false',
		'elemType': 'p',
		'matchedClass' : ''
	});
	/*
	hideByText(' with ease', {
		'match': 'partial',
		'sensitive': 'false',
		'elemType': 'span',
		'matchedClass' : ''
	});
	*/
}