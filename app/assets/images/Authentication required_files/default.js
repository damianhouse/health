//FrameBuster Code - to escape from hidden frames
function escapeFrame() {
  if ( top != self ) top.location.href = unescape(window.location.pathname);
}

function getWidth() {
  if ( window.innerWidth ) return window.innerWidth // all except iepxloiter
  else if( document.documentElement && document.documentElement.clientWidth ) return document.documentElement.clientWidth; // iexploiter strict mode
  else if( document.body ) return document.body.clientWidth; // should match the rest
  else return 0;
}

function getHeight() {
  if ( self.innerHeight ) return self.innerHeight // all except iepxloiter
  else if( document.documentElement && document.documentElement.clientHeight ) return document.documentElement.clientHeight; // iexploiter strict mode
  else if( document.body ) return document.body.clientHeight; // should match the rest
  else return 0;
}


function calcResize(wanted,actual) {
    if (actual < wanted) return (wanted - actual);
    else return 0;
}

// Popup resizer to automatically resize none resizable popups
function checkResize() {

  var actualWidth = getWidth();
  var actualHeight = getHeight();

  if ( top != self ) {
    var forcedWidth = 450;
    var forcedHeight = 350;

    // resize window
    var increaseWidth = calcResize( forcedWidth, actualWidth );
    var increaseHeight = calcResize( forcedHeight, actualHeight );

    if ( increaseWidth != 0 || increaseHeight != 0 ) {
		  // disable detail (default) page, enable small version
			document.getElementById("emsg_large").style.display = "none";
      document.body.style.margin = "0px 0px 0px 0px";
		  return 0;
		}
		
		document.getElementById("emsg_large").style.display = "inline";
    return 0;
  } else {
    // seems that we are in popup or regular page
    document.getElementById("emsg_large").style.display = "inline";

    if ( window.opener != window ) {

      // minimum browser page dimensions    
      var forcedWidth = 700;
      var forcedHeight = 350;
  
      // check if we can get the right numbers, if not, do nothing
      if (actualWidth == 0 || actualHeight == 0) {
          return 0;
      }

      // resize window
      var increaseWidth = calcResize(forcedWidth,actualWidth);
      var increaseHeight = calcResize(forcedHeight,actualHeight);

      // do resizing of the window if needed
      if (increaseWidth != 0 || increaseHeight != 0) {
  	    self.resizeBy(increaseWidth,increaseHeight);
      }
    }
  }
}

function showDetails()
{
	document.getElementById("details1").style.display = "inline";
	document.getElementById("details2").style.display = "inline";
	document.getElementById("details2").style.width = "100%";
}

function error(element, message) {
    var el = document.getElementById(element);
    el.innerHTML = message;
    el.style.display = 'inline';
}

function acceptTerms() {
    var guestLink = document.getElementById('guestuser');
    if(!guestLink) {
        return;
    }
    if(typeof acceptTerms.orighref == 'undefined') {
        acceptTerms.orighref = guestLink.href;
    }
    if(document.getElementById('accept').checked) {
        guestLink.href = acceptTerms.orighref + '&accept=accept';
    } else {
        guestLink.href = acceptTerms.orighref;
    }
}
