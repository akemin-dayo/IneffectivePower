#import <CoreFoundation/CoreFoundation.h>
#import <CoreText/CoreText.h>
#import <substrate.h>

static CTLineRef (*orig_line)(CFAttributedStringRef string);
static CTLineRef ineffectify_line(CFAttributedStringRef string) {
	if ([[(__bridge NSAttributedString*)string string] containsString:@"ॣ"]) {
		return orig_line(CFAttributedStringCreate(NULL, (__bridge CFStringRef)[[(__bridge NSAttributedString*)string string] stringByReplacingOccurrencesOfString:@"ॣ" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [[(__bridge NSAttributedString*)string string] length])], CFAttributedStringGetAttributes(string, 0, NULL)));
	}
	return orig_line(string);
}

static CTFramesetterRef (*orig_frame)(CFAttributedStringRef string);
static CTFramesetterRef ineffectify_frame(CFAttributedStringRef string) {
	if ([[(__bridge NSAttributedString*)string string] containsString:@"ॣ"]) {
		return orig_frame(CFAttributedStringCreate(NULL, (__bridge CFStringRef)[[(__bridge NSAttributedString*)string string] stringByReplacingOccurrencesOfString:@"ॣ" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [[(__bridge NSAttributedString*)string string] length])], CFAttributedStringGetAttributes(string, 0, NULL)));
	}
	return orig_frame(string);
}

%ctor {
	MSHookFunction(CTLineCreateWithAttributedString, ineffectify_line, &orig_line);
	MSHookFunction(CTFramesetterCreateWithAttributedString, ineffectify_frame, &orig_frame);
}