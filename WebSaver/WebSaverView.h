//
//  WebSaverView.h
//  WebSaver
//
//  Created by Greg Kellogg on 9/21/12.
//
//

#import <ScreenSaver/ScreenSaver.h>

#import <WebKit/WebKit.h>

@interface WebSaverView : ScreenSaverView
{
	IBOutlet id configSheet;
	IBOutlet id url;
	WebView *webView;
}

@end
