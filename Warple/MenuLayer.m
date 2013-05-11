//
//  MenuLayer.m
//  Warple
//
//  Created by Marc Frankel on 1/6/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import "MenuLayer.h"
#import "Game.h"
#import "WorldSelectLayer.h"
#import "SimpleAudioEngine.h"
#import "CreditLayer.h"
#import "ParticleBackgroundLayer.h"
#import "TestFlight.h"
#import "MKStoreManager.h"


@implementation MenuLayer



+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
    
    ParticleBackgroundLayer *ParticleLayer = [ParticleBackgroundLayer node];
	[scene addChild:ParticleLayer z:-3];
    ParticleLayer.tag= 5;
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	
	// return the scene
	return scene;
}
-(void)LoadWorldSelect{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCW transitionWithDuration:.5 scene:[WorldSelectLayer scene]]];
}
-(void)testgamecent{
    //load game center ui here
    [self showAchievements];
}

-(void)Loadcredits{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[CreditLayer scene]]];
}
-(void)Instructions{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
}
-(void)Reset{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[MKStoreManager sharedManager] removeAllKeychainData];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"8F96C70252ACADF31B4F5A91B2CA425A"];
    [defaults setBool:NO forKey:@"A0843A138E93C609FC292486D9BB40FE"];
    [defaults setInteger:0 forKey:@"AEC0A589A65770421811A7CF3698CB42"];
    
    for (int i=1; i<=15; i++) {
    NSString *tempstring = [NSString stringWithFormat:@"GemsGained%i.%i",1,i];
    [defaults setInteger:0 forKey:tempstring];
    }
    for (int i=1; i<=15; i++) {
        NSString *tempstring = [NSString stringWithFormat:@"GemsGained%i.%i",2,i];
        [defaults setInteger:0 forKey:tempstring];
    }
    for (int i=2; i<=15; i++) {
    NSString *tempstring = [NSString stringWithFormat:@"HasWon_%i.%i",1,i];
    [defaults setObject:Nil forKey:tempstring];
    }
    for (int i=1; i<=15; i++) {
        NSString *tempstring = [NSString stringWithFormat:@"HasWon_%i.%i",2,i];
        [defaults setObject:Nil forKey:tempstring];
    }
    [defaults setInteger:nil forKey:@"Warps"];
    [self resetAchievements];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (void) resetAchievements
{
    // Clear all locally saved achievement objects
    // Clear all progress saved on Game Center.
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error)
     {
         if (error != nil){
             NSLog(@"Error in restarting");
         }else{
             NSLog(@"Achievments Reseted");
         }
         
     }];
}
-(IBAction)launchFeedback {
    [TestFlight openFeedbackView];
}

- (void) authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
        if (localPlayer.isAuthenticated)
        {
            // Perform additional tasks for the authenticated player.
        }
    }];
}
- (void) showAchievements
{
    GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
    if (achievements != nil)
    {
        
        achievements.achievementDelegate = self;
        [viewController presentViewController:achievements animated:YES completion:nil];
    }
}
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

-(id)init{
    
    if (self = [super initWithColor:ccc4(255,255,255,0)]) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        if([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying] == FALSE)
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"warple.mp3" loop:YES];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"button-21.mp3"];
        
        [self authenticateLocalPlayer];
        AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        viewController = [app navController];
        
        CCLabelTTF * lable = [CCLabelTTF labelWithString:@"Warple" fontName:@"Danube" fontSize:32];
        
        CCMenuItem * start = [CCMenuItemImage itemWithNormalImage:@"Menu_button_Start-U.png" selectedImage:@"Menu_button_Start-D.png" target:self selector:@selector(LoadWorldSelect)];
        CCMenuItem *credits = [CCMenuItemImage itemWithNormalImage:@"Menu_button_Credits-U.png" selectedImage:@"Menu_button_Credits-D.png" target:self selector:@selector(Loadcredits)];
        CCMenuItem *instructions = [CCMenuItemImage itemWithNormalImage:@"Menu_button_Instructions-U.png" selectedImage:@"Menu_button_Instructions-D.png" target:self selector:@selector(loadtest)];
        CCMenuItem *GameCenter = [CCMenuItemImage itemWithNormalImage:@"Gamecenter.png" selectedImage:@"Gamecenter.png" target:self selector:@selector(testgamecent)];
        
        CCMenuItem *TestFlight = [CCMenuItemImage itemWithNormalImage:@"Testflight-icon.png" selectedImage:@"Testflight-icon.png" target:self selector:@selector(launchFeedback)];
        CCMenuItem *Reset = [CCMenuItemImage itemWithNormalImage:@"Reset.png" selectedImage:@"Reset.png" target:self selector:@selector(Reset)];
        
        CCMenu *mainMenu = [CCMenu menuWithItems:start,credits,instructions,Reset, nil];
        mainMenu.position = ccp(winSize.width/2,(winSize.height/2)-80 +Reset.contentSize.height);
        [mainMenu alignItemsVerticallyWithPadding:80];
        [self addChild:mainMenu];
        CCMenu *bottomMenu = [CCMenu menuWithItems:TestFlight, GameCenter, nil];
        [bottomMenu alignItemsHorizontallyWithPadding:10];
        bottomMenu.position = ccp(winSize.width-75, 30);
        [self addChild:bottomMenu];

        lable.color = ccc3(255,255,255);
        lable.position =ccp(winSize.width/2, winSize.height -50);
        [self addChild:lable];
    }
    return self;
}



@end
