//
//  MinecraftRemoteAppDelegate.m
//  MinecraftRemote
//
//  Created by Caius Durling on 07/11/2010.
//  Copyright (c) 2010 Swedishcampground Software. All rights reserved.
//

#import "MinecraftRemoteAppDelegate.h"
#import "RemoteController.h"

@interface MinecraftRemoteAppDelegate ()
@property (retain, readwrite) RemoteController *remoteController;
@end

@implementation MinecraftRemoteAppDelegate

@synthesize window;
@synthesize remoteController = _remoteController;
@synthesize stateButton = _stateButton;
@synthesize modeLabel = _modeLabel;
@synthesize controlEventString = _controlEventString;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
  
  self.remoteController = [RemoteController new];
  [self.remoteController start];
}

- (void) applicationWillTerminate:(NSNotification *)notification
{
  [self.remoteController stop];
}

- (IBAction) buttonToggle:(id)sender
{
  NSLog(@"buttonToggle:");
  NSLog(@"Button says %@", self.stateButton.title);
  if ([[self.stateButton title] isEqualToString:@"Stop"]) {
    self.stateButton.title = @"Start";
    [self.remoteController stop];
  } else {
    self.stateButton.title = @"Stop";
    [self.remoteController start];
  }
}

- (void) pressKey:(NSString*)keyCode
{
  //  NSLog(@"Will press key %@", keyCode);
  self.controlEventString = keyCode;
}

- (void)dealloc {

  [window release];
    [super dealloc];
}

@end
