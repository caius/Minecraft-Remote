//
//  RemoteController.m
//  MinecraftRemote
//
//  Created by Caius Durling on 07/11/2010.
//  Copyright (c) 2010 Swedishcampground Software. All rights reserved.
//

#import "RemoteController.h"
#import "HIDRemote.h"
#import "MinecraftRemoteAppDelegate.h"

@interface RemoteController ()
@property (assign, readwrite) SCGRemoteMode state;
- (void) switchMode;
- (NSString*) keycodeForButton:(HIDRemoteButtonCode)buttonCode mode:(SCGRemoteMode)state;
- (NSString*) keyCodeForSCGControl:(SCGControlEventName)controlEvent;
@end

@implementation RemoteController

@synthesize state = _state;

- (id) init
{
  if ((self = [super init])) {
    [[HIDRemote sharedHIDRemote] setDelegate:self];
    self.state = SCGRemoteMovementMode;
  }
  return self;
}

- (void) start
{
  NSLog(@"Remote starting");
  [[HIDRemote sharedHIDRemote] startRemoteControl:kHIDRemoteModeExclusive];
}

- (void) stop
{
  NSLog(@"Remote stopping");
  [[HIDRemote sharedHIDRemote] stopRemoteControl];
}

- (NSString*) modeString
{
  switch(self.state) {
    case SCGRemoteMovementMode:
      return @"Movement";
      break;
    case SCGRemoteCameraMode:
      return @"Camera";
      break;
  }
}

#pragma mark -
#pragma mark Private Methods

- (void) hidRemote:(HIDRemote *)hidRemote eventWithButton:(HIDRemoteButtonCode)buttonCode isPressed:(BOOL)isPressed fromHardwareWithAttributes:(NSMutableDictionary *)attributes
{
  NSLog(@"%@: Button with code %d %@", hidRemote, buttonCode, (isPressed ? @"pressed" : @"released"));

  // Ignore all key presses for now, we only respond to releases
  if (isPressed)
    return;

  if (buttonCode == kHIDRemoteButtonCodeMenu) {
    // We need to switch remote mode
    NSLog(@"Menu button received");
    [self switchMode];
    return;
  }

  NSString *keyCode = [self keycodeForButton:buttonCode mode:self.state];
  if ([keyCode isEqualToString:@""]) {
    return;
  }

  [[NSApp delegate] pressKey:keyCode];
}

- (void) switchMode
{
  NSLog(@"Current mode: %@", [self modeString]);
  NSLog(@"Switching mode!");
  [self willChangeValueForKey:@"modeString"];
  if (self.state == SCGRemoteMovementMode) {
    self.state = SCGRemoteCameraMode;
  } else {
    self.state = SCGRemoteMovementMode;
  }
  [self didChangeValueForKey:@"modeString"];
  NSLog(@"Mode switched!");
  NSLog(@"New mode: %@", [self modeString]);
}

- (NSString*) keycodeForButton:(HIDRemoteButtonCode)buttonCode mode:(SCGRemoteMode)state
{
  NSDictionary *keys;
  switch(state) {
  case SCGRemoteMovementMode:
    keys = [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:SCGControlMoveForward],   [NSNumber numberWithInt:kHIDRemoteButtonCodeUp],
            [NSNumber numberWithInt:SCGControlMoveBackward],  [NSNumber numberWithInt:kHIDRemoteButtonCodeDown],
            [NSNumber numberWithInt:SCGControlMoveLeft],      [NSNumber numberWithInt:kHIDRemoteButtonCodeLeft],
            [NSNumber numberWithInt:SCGControlMoveRight],     [NSNumber numberWithInt:kHIDRemoteButtonCodeRight],
            [NSNumber numberWithInt:SCGControlClick],         [NSNumber numberWithInt:kHIDRemoteButtonCodeCenter],
            [NSNumber numberWithInt:SCGControlJump],          [NSNumber numberWithInt:kHIDRemoteButtonCodePlay],
            nil];
    break;

  case SCGRemoteCameraMode:
    keys = [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:SCGControlTiltUp],      [NSNumber numberWithInt:kHIDRemoteButtonCodeUp],
            [NSNumber numberWithInt:SCGControlTiltDown],    [NSNumber numberWithInt:kHIDRemoteButtonCodeDown],
            [NSNumber numberWithInt:SCGControlTiltLeft],    [NSNumber numberWithInt:kHIDRemoteButtonCodeLeft],
            [NSNumber numberWithInt:SCGControlTiltRight],   [NSNumber numberWithInt:kHIDRemoteButtonCodeRight],
            [NSNumber numberWithInt:SCGControlClick],       [NSNumber numberWithInt:kHIDRemoteButtonCodeCenter],
            [NSNumber numberWithInt:SCGControlRightClick],  [NSNumber numberWithInt:kHIDRemoteButtonCodePlay],
            nil];
    break;

  default:
    return @"";
  }

  NSInteger movement;
  if ((movement = [[keys objectForKey:[NSNumber numberWithInt:(NSInteger)buttonCode]] intValue])) {
    return [self keyCodeForSCGControl:movement];
  }

  return @"";
}

- (NSString*) keyCodeForSCGControl:(SCGControlEventName)controlEvent
{
  NSLog(@"%@", controlEvent);
  switch(controlEvent) {
    case SCGControlMoveForward:
      //      return @"13";
      return @"w";
      break;
    case SCGControlMoveBackward:
      //      return @"1";
      return @"s";
      break;
    case SCGControlMoveLeft:
      //      return @"0";
      return @"a";
      break;
    case SCGControlMoveRight:
      //      return @"2";
      return @"d";
      break;
    case SCGControlJump:
//      return @"49";
      return @"space";
      break;
    case SCGControlClick:
      return @"left click";
      break;
    case SCGControlRightClick:
      return @"right click";
      break;
    case SCGControlTiltUp:
      return @"mouse up";
      break;
    case SCGControlTiltDown:
      return @"mouse down";
      break;
    case SCGControlTiltLeft:
      return @"mouse left";
      break;
    case SCGControlTiltRight:
      return @"mouse right";
      break;
    default:
      return @"";
  }
}

- (void)dealloc {
  // Clean-up code here.
  [super dealloc];
}

@end
