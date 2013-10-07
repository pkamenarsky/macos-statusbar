#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NSStatusItem *getStatusItem(NSMenu *menu) {
    [NSAutoreleasePool new];
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    NSStatusItem *item = [bar statusItemWithLength:NSVariableStatusItemLength];
    [item retain];
    [item setEnabled:YES];
    [item setHighlightMode:YES];

	[item setMenu:menu];

	return item;
}

NSMenu *createMenu(char *title) {
    NSMenu *menu = [[NSMenu alloc] initWithTitle:[[NSString alloc] initWithUTF8String:title]];
	[menu setAutoenablesItems:NO];

	return menu;
}

NSMenu *getStatusBarMenu() {
    [NSAutoreleasePool new];
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    
    NSStatusItem *item = [bar statusItemWithLength:NSVariableStatusItemLength];
    [item retain];
    [item setEnabled:YES];
    [item setHighlightMode:YES];
    
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Menu"];    
	[menu setAutoenablesItems:NO];
    [item setMenu:menu];
    
    return menu;
}

NSImage *getImageWithContentsOfFile(char *file, bool template) {
	NSImage *image = [[NSImage alloc] initWithContentsOfFile:[[NSString alloc] initWithUTF8String:file]];
	[image setTemplate:template];

	return image;
}

void setMenuTitle(NSMenu *menu, char *title) {
    [menu setTitle:[[NSString alloc] initWithUTF8String:title]];
}

void setStatusItemTitle(NSStatusItem *item, char *title) {
    [item setTitle:[[NSString alloc] initWithUTF8String:title]];
}

void setStatusItemImage(NSStatusItem *item, NSImage *image) {
    [item setImage:image];
}

NSMenuItem *addItem(NSMenu *menu, char *title, void (*f)(void)) {
    id sel = [^{f();} copy];
    
    NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:[[NSString alloc] initWithUTF8String:title] action:@selector(invoke) keyEquivalent:@""];
    
    [menuItem setTarget:sel];
    
    [menuItem setEnabled:YES];
    [menu addItem:menuItem];
    
    [sel autorelease];

	return menuItem;
}

void removeItem(NSMenu *menu, NSMenuItem *item) {
	[menu removeItem:item];
}

void removeItemAtIndex(NSMenu *menu, int index) {
	[menu removeItemAtIndex:index];
}

NSMenuItem *addSeparator(NSMenu *menu) {
    NSMenuItem *menuItem = [NSMenuItem separatorItem];
    [menu addItem:menuItem];

	return menuItem;
}

void setEnabled(NSMenuItem *item, bool enabled) {
	[item setEnabled:enabled];
}

void runLoop() {
    [NSApp activateIgnoringOtherApps:YES];
    [NSApp run];
}

