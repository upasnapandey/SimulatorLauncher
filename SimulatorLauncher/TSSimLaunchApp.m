//
//  TSSimLaunchApp.m
//  SimulatorLauncher
//
//  Created by Upasna Pandey on 6/7/16.
//  Copyright © 2016 TradeStation. All rights reserved.
//
#import <FBSimulatorControl/FBSimulatorControl.h>
#import "TSSimLaunchApp.h"

@interface TSSimLaunchApp ()

@property (strong, nonatomic) FBSimulatorControl *simulatorControl;

@end

@implementation TSSimLaunchApp

- (instancetype)init
{
    if (self = [super init]) {
        FBSimulatorManagementOptions managementOptions = 0;
        FBSimulatorControlConfiguration *controlConfiguration = [FBSimulatorControlConfiguration
        configurationWithDeviceSetPath:nil
        options:managementOptions];
        NSError *error = nil;
        FBSimulatorControl *control = [FBSimulatorControl withConfiguration:controlConfiguration error:&error];
        self.simulatorControl = control;

    }

    return self;
}

- (NSDictionary *)deviceMapping {
    return @{
            @"iPhone 4s:8.4": [FBSimulatorConfiguration.iPhone4s iOS_8_4],
            @"iPhone 5:8.4": [FBSimulatorConfiguration.iPhone5 iOS_8_4],
            @"iPhone 5s:8.4": [FBSimulatorConfiguration.iPhone5s iOS_8_4],
            @"iPhone 6:8.4": [FBSimulatorConfiguration.iPhone6 iOS_8_4],
            @"iPhone 6s:8.4": [FBSimulatorConfiguration.iPhone6s iOS_8_4],
            @"iPhone 6sPlus:8.4": [FBSimulatorConfiguration.iPhone6sPlus iOS_8_4],
            @"iPad Air:8.4": [FBSimulatorConfiguration.iPadAir iOS_8_4],
            @"iPad 2:8.4": [FBSimulatorConfiguration.iPad2 iOS_8_4],
            
            @"iPhone 4s:9.0": [FBSimulatorConfiguration.iPhone4s iOS_9_0],
            @"iPhone 5:9.0": [FBSimulatorConfiguration.iPhone5 iOS_9_0],
            @"iPhone 5s:9.0": [FBSimulatorConfiguration.iPhone5s iOS_9_0],
            @"iPhone 6:9.0": [FBSimulatorConfiguration.iPhone6 iOS_9_0],
            @"iPhone 6s:9.0": [FBSimulatorConfiguration.iPhone6s iOS_9_0],
            @"iPhone 6sPlus:9.0": [FBSimulatorConfiguration.iPhone6sPlus iOS_9_0],
            @"iPad Air:9.0": [FBSimulatorConfiguration.iPadAir iOS_9_0],
            @"iPad 2:9.0": [FBSimulatorConfiguration.iPad2 iOS_9_0],
            
            @"iPhone 4s:9.3": [FBSimulatorConfiguration.iPhone4s iOS_9_3],
            @"iPhone 5:9.3": [FBSimulatorConfiguration.iPhone5 iOS_9_3],
            @"iPhone 5s:9.3": [FBSimulatorConfiguration.iPhone5s iOS_9_3],
            @"iPhone 6:9.3": [FBSimulatorConfiguration.iPhone6 iOS_9_3],
            @"iPhone 6s:9.3": [FBSimulatorConfiguration.iPhone6s iOS_9_3],
            @"iPhone 6sPlus:9.3": [FBSimulatorConfiguration.iPhone6sPlus iOS_9_3],
            @"iPad Air:9.3": [FBSimulatorConfiguration.iPadAir iOS_9_3],
            @"iPad 2:9.3": [FBSimulatorConfiguration.iPad2 iOS_9_3],
            };
}

- (void)runWithArgc:(int)argc argv:(const char**)argv;
{
    NSString *device = [NSString stringWithFormat:@"%s:%s",argv[1],argv[2]];
    NSString *appPath = [NSString stringWithFormat:@"%s",argv[3]];
    NSLog(@"Device to be launched %@",device);
    [self startSimulatorWithId:device appPath:appPath];

}

- (NSString*)startSimulatorWithId:(NSString *)deviceName appPath:appPath
{
    NSDictionary *deviceMapping = [self deviceMapping];
    FBSimulatorConfiguration *simulatorConfiguration = deviceMapping[deviceName];
    
    if (!simulatorConfiguration) {
        NSLog(@"no matching config found");
    }
    
    
    FBSimulatorAllocationOptions allocationOptions = FBSimulatorAllocationOptionsCreate;   // | FBSimulatorAllocationOptionsReuse | FBSimulatorAllocationOptionsEraseOnAllocate;
    
    NSError *error;
    FBSimulator *simulator = [self.simulatorControl.pool allocateSimulatorWithConfiguration:simulatorConfiguration options:allocationOptions error:&error];
    
    NSLog(@"is allocated %d", simulator.isAllocated);

    FBSimulatorApplication *application = [FBSimulatorApplication applicationWithPath:appPath error:&error];
    if(application == nil) 
        NSLog(@"Application NOT Found");
    FBApplicationLaunchConfiguration *appLaunch = [FBApplicationLaunchConfiguration
                                                   configurationWithApplication:application
                                                   arguments:@[]
                                                   environment:@{}
                                                   options:0];
    
    BOOL install = [[[simulator.interact bootSimulator] installApplication:application] perform:&error];
    BOOL success = [[simulator.interact launchApplication:appLaunch] perform:&error];
    if(install && success){
        NSLog(@"install success");
        NSLog(@"Simulator UDID : %@", simulator.udid);
        printf("%s", [simulator.udid cStringUsingEncoding:NSUTF8StringEncoding]);
        return simulator.udid;
    } else
        return @"Error";
}

@end
