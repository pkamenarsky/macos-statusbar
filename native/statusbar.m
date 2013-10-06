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
    [item setMenu:menu];
    
    return menu;
}

void addMenuItem(NSMenu *menu, char *title, void (*f)(void)) {
    id sel = [^{f();} copy];
    
    NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:[[NSString alloc] initWithUTF8String:title] action:@selector(invoke) keyEquivalent:@""];
    
    [menuItem setTarget:sel];
    
    [menuItem setEnabled:YES];
    [menu addItem:menuItem];
    
    [sel autorelease];
}

// enable, disable items, icon for status bar

void runLoop() {
    [NSApp activateIgnoringOtherApps:YES];
    [NSApp run];
}

