//
//  AppDelegate.h
//  Warple
//
//  Created by Marc Frankel on 1/6/13.
//  Copyright Señor Fantástico Games 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "RootViewController.h"


// Added only for iOS 6 support

@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end


@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;
	CCDirectorIOS	*__weak director_;							// weak ref

}



@property (nonatomic, strong) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (weak, readonly) CCDirectorIOS *director;
@property (nonatomic,strong) RootViewController *viewController;


@end
