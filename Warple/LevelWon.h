//
//  LevelWon.h
//  Warple
//
//  Created by Marc Frankel on 3/24/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"
#import "AppDelegate.h"
#import "RootViewController.h"
enum GameSatePP2 {
    kGameStatePlaying2,
    KGameStatePaused2
};

@interface LevelWon : CCLayerColor <AdWhirlConfigDelegate> {
    UINavigationController *viewController;
    AdWhirlView *adWhirlView;
    CGSize CurrentAdHeight;
    CCSprite *Gem1;
    CCSprite *Gem2;
    CCSprite *Gem3;
    
    int PlayersLevel;
    int PlayersWorld;
    
}
@property (nonatomic, strong) AdWhirlView *adWhirlView;
@property (nonatomic) enum GameSatePP2 state;

+(CCScene *) sceneWithData:(int)levelNum mapWorldNum:(int)mapWorldNum timeLeft:(int)timeLeft totalTime:(int)totalTime gemsCollected:(int)gemsCollected otherGems:(int)otherGems totalOtherGems:(int)totalOtherGems;

- (id)initWithData:(int)levelNum mapWorldNum:(int)mapWorldNum timeLeft:(int)timeLeft totalTime:(int)totalTime gemsCollected:(int)gemsCollected otherGems:(int)otherGems totalOtherGems:(int)totalOtherGems;
@end
