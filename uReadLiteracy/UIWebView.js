var uiWebview_SearchResultCount = 0;


function uiWebview_HighlightAllOccurencesOfStringForElement(element,keyword,color) {
    
    var queue = [];
    queue.push(document.body);
    
    var count = 0;
    
    while(queue.length != 0){
        var element = queue.shift();
        
        if (element) {
            if (element.nodeType == 3) {        // Text node
                while (true) {
                    //if (counter < 1) {
                    var value = element.nodeValue;  // Search for keyword in text node
                    var idx = value.toLowerCase().indexOf(keyword);
                    
                    if (idx < 0) break;             // not found, abort
                    
                    //(value.split);
                    
                    //we create a SPAN element for every parts of matched keywords
                    var span = document.createElement("span");
                    var text = document.createTextNode(value.substr(idx,keyword.length));
                    span.appendChild(text);
                    
                    
                    
                    span.setAttribute("class","uiWebviewHighlight");
                    span.style.backgroundColor = color;
                    span.style.color="black";
                    
                    
                    
                    uiWebview_SearchResultCount++;    // update the counter
                    
                    text = document.createTextNode(value.substr(idx+keyword.length));
                    element.deleteData(idx, value.length - idx);
                    var next = element.nextSibling;
                    element.parentNode.insertBefore(span, next);
                    element.parentNode.insertBefore(text, next);
                    element = text;
                    //window.scrollTo(0,span.offsetTop);
                    
                }
            } else if (element.nodeType == 1) { // Element node
                if (element.style.display != "none" && element.nodeName.toLowerCase() != 'select') {
                    for (var i=element.childNodes.length-1; i>=0; i--) {
                        queue.push(element.childNodes[i]);
                    }
                }
                element.removeAttribute("href")
            }
        }
        count = count + 1;
    }
    //return uiWebview_SearchResultCount;
}

// the main entry point to start the search

function uiWebview_HighlightAllOccurencesOfString(keyword,color) {
    uiWebview_HighlightAllOccurencesOfStringForElement(document.body, keyword.toLowerCase(),color);
}

function uiWebview_getAllParagraphs() {
    var arr = [];
    var x = document.getElementsByTagName('p');
    var i;
    
    for (i = 0; i < x.length; i++) {
        arr.push(x[i].textContent);
        
    }
    
    
    return arr.join('');
}

// helper function, recursively removes the highlights in elements and their childs
function uiWebview_RemoveAllHighlightsForElement(element) {
    if (element) {
        if (element.nodeType == 1) {
            if (element.getAttribute("class") == "uiWebviewHighlight") {
                var text = element.removeChild(element.firstChild);
                element.parentNode.insertBefore(text,element);
                element.parentNode.removeChild(element);
                return true;
            } else {
                var normalize = false;
                for (var i=element.childNodes.length-1; i>=0; i--) {
                    if (uiWebview_RemoveAllHighlightsForElement(element.childNodes[i])) {
                        normalize = true;
                    }
                }
                if (normalize) {
                    element.normalize();
                }
            }
        }
    }
    return false;
}
// the main entry point to remove the highlights
function uiWebview_RemoveAllHighlights() {
    uiWebview_SearchResultCount = 0;
    uiWebview_RemoveAllHighlightsForElement(document.body);
}

function runner() {
    for(i=1;document.anchors.length > 0;i++) {
        //alert('run ' + i + ':' + document.anchors.length);
        removehyperlinks();
    }
}