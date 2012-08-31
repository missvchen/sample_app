$(document).ready(function () {
	$(".tracking_char_input").keyup(function(e) {
		var newLineRegEx = /(\r\n|\n|\r)/g;
		var text = $(this).val();
		
		var newLines = text.match(newLineRegEx),
			newLinesCount = newLines ? newLines.length : 0,	// gets number of enter key presses
			length = text.length + newLinesCount,			// Chrome counts them as 2 characters
			set = $(this).attr("maxlength"),
			remain = parseInt(set - length);
			
		remain = remain <= 0 ? 0 : remain;
		
		var remainingCharLabel = $(this).parent().siblings(".remaining_char_note");
		var newText = remainingCharLabel.text();
		remainingCharLabel.text(newText.replace(/(\d+)/g, remain));
		
		if (remain <= 0) {
			var browser = navigator.userAgent;
			if (browser.indexOf("Chrome") != -1)
			{
				return;
			}
			
			$(this).val(text.substring(0, set - newLinesCount));
		}
	});
});