//
//  SimulatorShaker.m
//  TestingHostUITests
//
//  Created by Kyle on 2025/2/18.
//

#import "SimulatorShaker.h"
#import <notify.h>

@implementation SimulatorShaker

+ (void)performShake {
    notify_post("com.apple.UIKit.SimulatorShake");
}

@end
