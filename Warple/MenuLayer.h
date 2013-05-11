//
//  MenuLayer.h
//  Warple
//
//  Created by Marc Frankel on 1/6/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AppDelegate.h"




@interface MenuLayer : CCLayerColor<GKLeaderboardViewControllerDelegate,GKAchievementViewControllerDelegate,GKGameCenterControllerDelegate> {
    UINavigationController *viewController;
}

@property (nonatomic,strong) CCParticleSystem *emmiter;

+(CCScene *) scene;


@end
