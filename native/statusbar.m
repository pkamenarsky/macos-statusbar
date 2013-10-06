#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NSMenu *getStatusBarMenu() {
    [NSAutoreleasePool new];
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    
    NSStatusItem *item = [bar statusItemWithLength:NSVariableStatusItemLength];
    [item retain];
    [item setTitle: NSLocalizedString(@"Tablet", @"")];
    NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericFolderIcon)];
    // [item setImage:icon];
    [item setEnabled:YES];
    [item setHighlightMode:YES];
    
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Menu"];    
	[menu setAutoenablesItems:NO];
    [item setMenu:menu];
    
    return menu;
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

// enable, disable items, icon for status bar

void runLoop() {
    [NSApp activateIgnoringOtherApps:YES];
    [NSApp run];
}

