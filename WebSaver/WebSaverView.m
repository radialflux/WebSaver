//
//  WebSaverView.m
//  WebSaver
//
//  Created by Greg Kellogg on 9/21/12.
//
//

#import "WebSaverView.h"

#import <WebKit/WebKit.h>

@implementation WebSaverView

static NSString * const ModuleName = @"fm.kelloggs.WebSaver";
static NSString * const DefaultURL = @"http://www.cisco.com";

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
		ScreenSaverDefaults *defaults =
        [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
        
		[defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
									DefaultURL, @"URL",
									nil]];
        
		webView = [[WebView alloc] initWithFrame:[self bounds] frameName:nil groupName:nil];
		[webView setMainFrameURL: [defaults valueForKey: @"URL"]];
		[self addSubview:webView];
    }
    return self;
}

- (BOOL)hasConfigureSheet
{
	return YES;
}

- (NSWindow *)configureSheet
{
	ScreenSaverDefaults *defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
    
	if (!configSheet)
	{
		if (![NSBundle loadNibNamed:@"ConfigureSheet" owner:self])
		{
			NSLog( @"Failed to load configure sheet." );
			NSBeep();
		}
	}
    
	[url setStringValue: [defaults valueForKey: @"URL"]];
    
	return configSheet;
}

// Invoked when the user clicks "OK"
- (IBAction) okClick: (id)sender
{
	ScreenSaverDefaults *defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
    
	NSString *value = [url stringValue];
	[defaults setValue: value forKey: @"URL"];
	[defaults synchronize];
	[webView setMainFrameURL: value];
    
	[[NSApplication sharedApplication] endSheet:configSheet];
}


- (IBAction)cancelClick:(id)sender
{
	[[NSApplication sharedApplication] endSheet:configSheet];
}

@end
