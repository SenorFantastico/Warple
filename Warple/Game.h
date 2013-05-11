//
//  Game.h
//  Warple
//
//  Created by Marc Frankel on 1/20/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import <StoreKit/StoreKit.h> 






enum GameSatePP {
    kGameStatePlaying,
    KGameStatePaused
};

@class SneakyJoystickSkinnedJoystickExample;

@interface Game : CCLayerColor <AdWhirlDelegate, UIAlertViewDelegate> {
    
    UINavigationController *viewController;
    CCTMXTiledMap *_tileMap;
    CCTMXLayer *_background;
    CCSprite *_player;
    AdWhirlView *adWhirlView;
    CCTMXLayer *_puzzle;
    CCTMXLayer *_Objects;
    CCSprite *_marker;
    CCMenuItemImage *Warp;
    SneakyJoystickSkinnedJoystickExample* joystick;
    CGPoint tempTileCoord;
    CCLayer *pauseLayer;
    CCSprite *_pauseScreen;
    CCSprite *menubar;
    CCMenu *_pauseScreenMenu;
    CCLabelTTF *PauseLabel;
    CCLabelTTF *TimeLabel;
    UISwitch *muteSwitch;
    CGSize CurrentAdHeight;
    CCSprite *Gem1;
    CCSprite *Gem2;
    CCSprite *Gem3;
    CCSprite *IcedWarple;
    CCAction * PlayerAnimationRepeat;
    CCMenuItemImage * pausebutton;
    NSString *maplevelDataNum;
    NSUserDefaults *defaults;
    BOOL *warpbuttonaction;
    BOOL *isRetina;
    BOOL *didFinish;
    BOOL *FroozenTurn;
    id warpbutton;
    BOOL _pauseScreenUp;
    int PlayersWorld;
    int PlayersLevel;
    int LevelTime;
    int GemsGained;
    float kGameUpadteTime;
    BOOL GameIsPaused;
    int OriganalLevelTime;
    int OtherGems;
    int TotalOthers;
    int TotalWarps;
}

@property (nonatomic, strong) CCTMXTiledMap *tilemap;
@property (nonatomic, strong) CCTMXLayer *background;
@property (nonatomic, strong) CCTMXLayer *puzzle;
@property (nonatomic, strong) CCSprite *player;
@property (nonatomic, strong) AdWhirlView *adWhirlView;
@property (nonatomic) enum GameSatePP state;
@property (nonatomic, strong) CCTMXLayer *meta;
@property (nonatomic, strong) CCSprite *marker;
@property (nonatomic, strong) CCTMXLayer *Objects;
@property (nonatomic, strong) CCTMXLayer *NoWarps;


- (id)initWithLevelData:(int)maplevelNum mapWorldNum:(int)mapWorldNum;
+(CCScene *) sceneWithLevelData:(int)mapName mapWorldNum:(int)mapWorldnum;


@end
