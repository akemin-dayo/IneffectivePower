#import <CoreFoundation/CoreFoundation.h>
#import <CoreText/CoreText.h>
#import <substrate.h>

static CTLineRef (*orig)(CFAttributedStringRef string);
static CTLineRef ineffectify(CFAttributedStringRef string) {
	return orig(CFAttributedStringCreate(NULL, (__bridge CFStringRef)[[(__bridge NSAttributedString*)string string] stringByReplacingOccurrencesOfString:@"ॣ" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [[(__bridge NSAttributedString*)string string] length])], CFAttributedStringGetAttributes(string, 0, NULL)));
}

static CTFramesetterRef (*orig_frame)(CFAttributedStringRef string);
static CTFramesetterRef ineffectify_frame(CFAttributedStringRef string) {
	return orig_frame(CFAttributedStringCreate(NULL, (__bridge CFStringRef)[[(__bridge NSAttributedString*)string string] stringByReplacingOccurrencesOfString:@"ॣ" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [[(__bridge NSAttributedString*)string string] length])], CFAttributedStringGetAttributes(string, 0, NULL)));
}

%ctor {
	MSHookFunction(CTLineCreateWithAttributedString, ineffectify, &orig);
	MSHookFunction(CTFramesetterCreateWithAttributedString, ineffectify_frame, &orig_frame);
}