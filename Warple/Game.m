//
//  Game.m
//  Warple
//
//  Created by Marc Frankel on 1/20/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//
#import "Game.h"

#import "MenuLayer.h"
#import "Constant.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyJoystickSkinnedJoystickExample.h"
#import "SimpleAudioEngine.h"
#import "WorldOneSelectLayer.h"
#import "WorldSelectLayer.h"
#import "GameOverLayer.h"
#import "WorldTwoSelectLayer.h"
#import "MKStoreManager.h"
#import "LevelWon.h"
#import <StoreKit/StoreKit.h>


@implementation Game

@synthesize tilemap = _tileMap;
@synthesize background = _background;
@synthesize puzzle =_puzzle;
@synthesize player = _player;
@synthesize state = _state, adWhirlView;
@synthesize marker = _marker;
@synthesize Objects = _Objects;
@synthesize NoWarps = _NoWarps;

#define kNonRetinaconstant 609; 

+(CCScene *)sceneWithLevelData:(int)mapName mapWorldNum:(int)mapWorldNum
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	// 'layer' is an autorelease object.
	Game *layer = [[Game node]initWithLevelData:mapName mapWorldNum:mapWorldNum];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}
//Main Method for all Alert views
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 1) {
        //Main Menu
        if (buttonIndex == 0) {     

        }
        if (buttonIndex == 1) {
            [self loadmenu];
        }
    }
    if ([alertView tag] == 2) {
        //World Select
        if (buttonIndex == 0) {
            
        }
        if (buttonIndex == 1) {
            [self WorldSelectButtonTapped];
        }
    }
    if ([alertView tag] == 3) {
        //Level Select
        if (buttonIndex == 0) {
            
        }
        if (buttonIndex == 1) {
            [self LevelSelectButtonTapped];
        }
    }
    if ([alertView tag] == 4) {
        //Level Restart
        if (buttonIndex == 0) {
            
        }
        if (buttonIndex == 1) {
            [self RestartLevelButtonTapped];
        }
    }
    if ([alertView tag] == 5) {
        //Purchase restored success
        if (buttonIndex == 0) {
            if([MKStoreManager isFeaturePurchased:@"com.senorfantasticogames.GoldenWarpleIAP"])
            {
                NSLog(@"Restored Golden Warple");
                [self UnlockGoldenWarple];
            } else if ([MKStoreManager isFeaturePurchased:@"com.senorfantasticogames.RemoveAdsIAP"]){
                NSLog(@"Restored Remove Ads");
            }
        }
    }
    if ([alertView tag] == 6) {
        //Purchase restored failure
        if (buttonIndex == 0) {
            
        }
    }
    if ([alertView tag] == 7) {
        //Purchase restored parental controls
        if (buttonIndex == 0) {
            
        }
    }
    if ([alertView tag] == 8) {
        //Purchase succeful Golden Warple
        if (buttonIndex == 0) {
            
        }
    }
    if ([alertView tag] == 9) {
        //Purchase succeful Remove Ads
        if (buttonIndex == 0) {
            
        }
    }
    if ([alertView tag] == 10) {
        //Purchase succeful Level skips x3
        if (buttonIndex == 0) {
            
        }
    }
}
-(void)QMainMenu{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Positive?" message:@"Are you sure you want to leave? All progress your will be lost..." delegate:self cancelButtonTitle:@"No" otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Yes"];
    [alert setTag:1];
    [alert show];
}
-(void)QWorldSelect{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Positive?" message:@"Are you sure you want to leave? All progress your will be lost..." delegate:self cancelButtonTitle:@"No" otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Yes"];
    [alert setTag:2];
    [alert show];
}
-(void)QLevelSelect{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Positive?" message:@"Are you sure you want to leave? All progress your will be lost..." delegate:self cancelButtonTitle:@"No" otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Yes"];
    [alert setTag:3];
    [alert show];
}
-(void)QRestartLevel{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Positive?" message:@"Are you sure you want to restart? All progress your will be lost..." delegate:self cancelButtonTitle:@"No" otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Yes"];
    [alert setTag:4];
    [alert show];
}

-(void)loadmenu{
    [self removeChild:_pauseScreen cleanup:YES];
    [self removeChild:_pauseScreenMenu cleanup:YES];
    [self removeChild:pauseLayer cleanup:YES];
    GameIsPaused = NO;
    [[CCDirector sharedDirector] resume];
    [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
    _pauseScreenUp=FALSE;
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[SimpleAudioEngine sharedEngine] stopEffect:@"Ticking.caf"];
     [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:.5 scene:[MenuLayer scene]]];
}
-(void)GameOver{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameOverLayer sceneWithLevelData:PlayersLevel mapWorldNum:PlayersWorld] ]];
}
- (CGPoint)tileCoordForPosition:(CGPoint)position {
    int x = position.x / _tileMap.tileSize.width;
    int y = ((_tileMap.mapSize.height * _tileMap.tileSize.height) - position.y) / _tileMap.tileSize.height;
    return ccp(x, y);
}
-(void)HandleGem{
    [_Objects removeTileAt:tempTileCoord];
    switch (GemsGained) {
        case 0:
            [Gem3 setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
            GemsGained = 1;
            NSLog(@"%D",GemsGained);
            break;
        case 1:
            [Gem2 setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
            GemsGained = 2;
            NSLog(@"%D",GemsGained);
            break;
        case 2:
            [Gem1 setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
            GemsGained = 3;
            NSLog(@"Got all gems");
            break;
    }
}
-(void)HandleUnFreeze{
    NSLog(@"Unfreeze");
    [[SimpleAudioEngine sharedEngine] playEffect:@"Ice_UF.mp3"];
    [_player runAction:PlayerAnimationRepeat];
    [self schedule:@selector(GameUpdate:) interval:kGameUpadteTime];
    [_player removeChild:IcedWarple cleanup:YES];
    [self WarpButtonType];
}
-(void)HandleFreeze{
    NSLog(@"Freeze");
    [_Objects removeTileAt:tempTileCoord];
    IcedWarple = [CCSprite spriteWithFile:@"WarpleNIce.png"];
    [_player addChild:IcedWarple z:20];
    IcedWarple.position = ccp(_player.contentSize.width/2, _player.contentSize.height/2);
    [self WarpButtonType:YES];
    [_player stopActionByTag:222];
    [self scheduleOnce:@selector(HandleUnFreeze) delay:4];
}
-(void)SlowDown{
    kGameUpadteTime = .6;
    NSLog(@"Slowed Down");
}
-(void)HandleSpeed{
    NSLog(@"Speed up");
    [_Objects removeTileAt:tempTileCoord];
    kGameUpadteTime =.3;
    [self unschedule:@selector(SlowDown)];
    [self scheduleOnce:@selector(SlowDown) delay:6];
}
-(void)CheckTilesForProperties{
    
        int tileGid = [_Objects tileGIDAt:tempTileCoord];
        NSDictionary *properties = [_tileMap propertiesForGID:tileGid];
    
        if (properties)
        {
            NSString *Finish = [properties valueForKey:@"Finish"];
            NSString *Yellow = [properties valueForKey:@"Yellow"];
            NSString *Freeze = [properties valueForKey:@"Freeze"];
            NSString *Speed = [properties valueForKey:@"Speed"];
            
            if (Finish && [Finish compare:@"True"] == NSOrderedSame)
            {
                [self HandleFinish:LevelTime collectedGems:GemsGained OtherGemsCollected:OtherGems];
            }
            else if (Yellow && [Yellow compare:@"True"] == NSOrderedSame)
            {
                [[SimpleAudioEngine sharedEngine] playEffect:@"PickUp.wav"];
                
                [self HandleGem];
            }
            else if (Freeze && [Freeze compare:@"True"] == NSOrderedSame)
            {
                [self unschedule:@selector(GameUpdate:)];
                [self HandleFreeze];
                OtherGems++;
            }
            else if (Speed && [Speed compare:@"True"] == NSOrderedSame)
            {
                [self HandleSpeed];
                OtherGems++;
            }
        }
}
-(void)AchievementHandleWarps{
    
    NSLog(@"Player Has Warped %i times",TotalWarps);
    float Warped_10 = (TotalWarps/10.0f)*100.0f;
    float Warped_100 = (TotalWarps/100.0f)*100.0f;
    float Warped_500 = (TotalWarps/500.0f)*100.0f;
    float Warped_1000 = (TotalWarps/1000.0f)*100.0f;
    NSLog(@"%.0f",Warped_10);
    
    if (TotalWarps<=10) {
        [self reportAchievementIdentifier:@"501710" percentComplete:Warped_10];
        [self reportAchievementIdentifier:@"5017100" percentComplete:Warped_100];
        [self reportAchievementIdentifier:@"5017warp500" percentComplete:Warped_500];
        [self reportAchievementIdentifier:@"50171000" percentComplete:Warped_1000];
    }else if (TotalWarps<=100) {
        [self reportAchievementIdentifier:@"5017100" percentComplete:Warped_100];
        [self reportAchievementIdentifier:@"5017warp500" percentComplete:Warped_500];
        [self reportAchievementIdentifier:@"50171000" percentComplete:Warped_1000];
    }else if (TotalWarps<=500) {
        [self reportAchievementIdentifier:@"5017warp500" percentComplete:Warped_500];
        [self reportAchievementIdentifier:@"50171000" percentComplete:Warped_1000];
    }
    else if (TotalWarps<=1000) {
        [self reportAchievementIdentifier:@"50171000" percentComplete:Warped_1000];
    }
    switch (TotalWarps) {
        case 10:
            //Show note
            break;
        case 100:
            //Show note
            break;
        case 500:
            //Show note
            break;
        case 1000:
            //Show note
            break;
            
        default:
            break;
    }
    
    //set achievments here
    [defaults setInteger:TotalWarps forKey:@"Warps"];
    [defaults synchronize];
}
-(void)HandleFinish:(int)CurrentLeveltime collectedGems:(int)collectedGems OtherGemsCollected:(int)OtherGemsCollected{
    [self AchievementHandleWarps];
    
    
    NSLog(@"Finished in %i with %i gems and %i otherGems",CurrentLeveltime,collectedGems, OtherGemsCollected);
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInB transitionWithDuration:1 scene:[LevelWon sceneWithData:PlayersLevel mapWorldNum:PlayersWorld timeLeft:CurrentLeveltime totalTime:OriganalLevelTime gemsCollected:collectedGems otherGems:OtherGemsCollected totalOtherGems:TotalOthers]]];
}
-(void)AnimateCharacter:(CGPoint)newPosistion movetype:(int)movetype{
    int mult = 2;
    
    if (isRetina)
    {
        mult = 1;
    }
    if(movetype == 0)
    {
        id moveCharacterAnimation =[CCMoveTo actionWithDuration:kGameUpadteTime-.05 position:ccp(newPosistion.x*(29*mult), _player.position.y)];
        id actionCallFunc = [CCCallFunc actionWithTarget:self selector:@selector(CheckTilesForProperties)];
        id actionCallFunc2 = [CCCallFunc actionWithTarget:self selector:@selector(WarpButtonType)];
        id actionSequence = [CCSequence actions:actionCallFunc,moveCharacterAnimation,actionCallFunc2, nil];
        tempTileCoord = newPosistion;
        [_player runAction:actionSequence];
    }
    else if (movetype == 1)
    {
        id moveCharacterAnimation = [CCMoveTo actionWithDuration:kGameUpadteTime-.05 position:ccp(_player.position.x, (290*mult)-newPosistion.y*(29*mult))];
        id actionCallFunc = [CCCallFunc actionWithTarget:self selector:@selector(CheckTilesForProperties)];
        id actionCallFunc2 = [CCCallFunc actionWithTarget:self selector:@selector(WarpButtonType)];
        id actionSequence = [CCSequence actions:actionCallFunc,moveCharacterAnimation,actionCallFunc2, nil];
        tempTileCoord = newPosistion;
        [_player runAction:actionSequence];
    }
}
-(void)MoveCharacter:(CGPoint)tileCoord movetype:(int)movetype{
    if (tileCoord.y < _tileMap.mapSize.height && tileCoord.y >=0 && tileCoord.x < _tileMap.mapSize.width && tileCoord.x >= 0)
    {
        int tileGid = [_puzzle tileGIDAt:tileCoord];
        
        if (tileGid) {
            NSDictionary *properties = [_tileMap propertiesForGID:tileGid];
            if (properties) {
                NSString *collision = [properties valueForKey:@"Collidable"];
                if (collision && [collision compare:@"True"] == NSOrderedSame) {
                    return;
                }
            }
        }
        [self AnimateCharacter:tileCoord movetype:movetype];
    }
}


- (CGPoint)tileCoordForPositionRay:(CGPoint)position {
    if(isRetina)
    {
    int x = (position.x / _tileMap.tileSize.width)/.5;
    int y = ((((_tileMap.mapSize.height * _tileMap.tileSize.height) - position.y) / _tileMap.tileSize.height)/.5)-_tileMap.mapSize.height;
    return ccp(x, y);
    } else {
        int x = (position.x / _tileMap.tileSize.width)/.5;
        int y = ((((_tileMap.mapSize.height * _tileMap.tileSize.height) - position.y) / _tileMap.tileSize.height));
        return ccp(x, y);
    }
}

-(void) WarpWarple:(id)sender{
    if (GameIsPaused)
    {
        return;
    }
    else
    {
        int div = 1;
        if (!isRetina)
        {
            div = 2;
        }
        if ([warpbutton isDone]==TRUE)
        {
            warpbuttonaction = FALSE;
        }
        if (warpbuttonaction == FALSE)
        {
            warpbutton = [CCRotateBy actionWithDuration:.5 angle:360];
            [Warp runAction:warpbutton];
            warpbuttonaction = TRUE;
        }

    CGPoint currentCorrd = [self tileCoordForPositionRay:self.player.position];
    currentCorrd.x = currentCorrd.x/div;
    currentCorrd.y = currentCorrd.y-1;
    CGPoint warpToCoord = ccp(-1*(int)currentCorrd.x+(_tileMap.mapSize.width-1),-1*(int)currentCorrd.y+(_tileMap.mapSize.height-1));
        
        int tileGid_Collidable = [_puzzle tileGIDAt:warpToCoord];
        if (tileGid_Collidable) {
            NSDictionary *properties = [_tileMap propertiesForGID:tileGid_Collidable];
            if (properties) {
                NSString *collision = [properties valueForKey:@"Collidable"];
                if (collision && [collision compare:@"True"] == NSOrderedSame) {
                    NSLog(@"Overriding current choice... Warp canceled");
                    return;
                }
            }
        }
        
        tempTileCoord = warpToCoord;
        _player.position = ccp(((int)warpToCoord.x)*(29*div),(290*div)-((int)warpToCoord.y)*(29*div));
        [self ReportAndSaveWarps];
        
        int tileGid_NoWarp = [_NoWarps tileGIDAt:currentCorrd];
        if (tileGid_NoWarp) {
            NSDictionary *properties = [_tileMap propertiesForGID:tileGid_NoWarp];
            if (properties) {
                NSString *NoWarp = [properties valueForKey:@"NoWarp"];
                if (NoWarp && [NoWarp compare:@"True"] == NSOrderedSame) {
                    
                    [Warp setIsEnabled:NO];
                }
            }
        }
        
        int tileGid_Finish = [_Objects tileGIDAt:warpToCoord];
        if (tileGid_Finish) {
            NSDictionary *properties = [_tileMap propertiesForGID:tileGid_Finish];
            if (properties) {
                NSString *Finish = [properties valueForKey:@"Finish"];
                if (Finish && [Finish compare:@"True"] == NSOrderedSame) {
                    [self CheckTilesForProperties];
                }
            }
        }
        
        int tileGid_Gem = [_Objects tileGIDAt:warpToCoord];
        if (tileGid_Gem) {
            NSDictionary *properties = [_tileMap propertiesForGID:tileGid_Gem];
            if (properties) {
                NSString *Gem = [properties valueForKey:@"Gem"];
                if (Gem && [Gem compare:@"True"] == NSOrderedSame) {
                    [self CheckTilesForProperties];
                }
            }
        }
    }
}
-(void)WarpButtonType:(BOOL)ManualShutOff{
    if(ManualShutOff == YES)
    {
        [Warp setIsEnabled:NO];
        FroozenTurn = YES;
    }
}
-(void)WarpButtonTypeSpecial:(CGPoint)WarpedFrom{
    
    int tileGid_NoWarp = [_NoWarps tileGIDAt:WarpedFrom];
    if (tileGid_NoWarp) {
        NSDictionary *properties = [_tileMap propertiesForGID:tileGid_NoWarp];
        if (properties) {
            NSString *NoWarp = [properties valueForKey:@"NoWarp"];
            if (NoWarp && [NoWarp compare:@"True"] == NSOrderedSame) {
                [Warp setIsEnabled:NO];
                return;
            }
        }
    }
}
-(void)WarpButtonType {
    if(FroozenTurn == NO )
    {
        int mult = 1;
        
    if (!isRetina)
    {
        mult = 2;
    }
        CGPoint currentCorrd = [self tileCoordForPositionRay:self.player.position];
        currentCorrd.x = currentCorrd.x/mult;
        currentCorrd.y = currentCorrd.y-1;
        CGPoint warpToCoord = ccp(-1*(int)currentCorrd.x+(_tileMap.mapSize.width-1),-1*(int)currentCorrd.y+(_tileMap.mapSize.height-1));
        
        int tileGid_Collidable = [_puzzle tileGIDAt:warpToCoord];
        if (tileGid_Collidable) {
            NSDictionary *properties = [_tileMap propertiesForGID:tileGid_Collidable];
            if (properties) {
                NSString *collision = [properties valueForKey:@"Collidable"];
                
                if (collision && [collision compare:@"True"] == NSOrderedSame) {
                    
                    [Warp setIsEnabled:NO];
                    return;
                }
            }
        }
        int tileGid_NoWarp = [_NoWarps tileGIDAt:warpToCoord];
        if (tileGid_NoWarp) {
            NSDictionary *properties = [_tileMap propertiesForGID:tileGid_NoWarp];
            if (properties) {
                NSString *NoWarp = [properties valueForKey:@"NoWarp"];
                if (NoWarp && [NoWarp compare:@"True"] == NSOrderedSame) {
                    
                    [Warp setIsEnabled:NO];
                    return;
                }
            }
        }
        [Warp setIsEnabled:YES];
    } else {
        FroozenTurn = NO;
    }
}
-(void)checkfordevicetype{
    if ([[CCDirector sharedDirector] enableRetinaDisplay:YES])//Check For Retina
    {
        isRetina = YES;
        NSLog(@"THIS DEVICE IS RETINA!");
    }else{
        isRetina = NO;
        NSLog(@"THIS DEVICE IS NOT RETINA!");
    }
}
-(void) addJoystick
{
    joystick = [[SneakyJoystickSkinnedJoystickExample alloc] init];
    joystick.joystick.isDPad =TRUE;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    if(isRetina){
            joystick.position = CGPointMake(winSize.width/2+80, 130);
        if(winSize.height != 568){
            joystick.scale = .73;
            joystick.position = CGPointMake(winSize.width/2+80, 86);
        }
    } else {
    
            joystick.position = CGPointMake(winSize.width/2+80, 85);
    }
    
	
	[self addChild:joystick];
}
-(void)PauseButtonTapped
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    [pausebutton setIsEnabled:NO];
    
    GameIsPaused = YES;
    
    if(_pauseScreenUp == FALSE)
    {
        _pauseScreenUp=TRUE;
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        [[CCDirector sharedDirector] pause];
        
        pauseLayer = [CCLayerColor layerWithColor: ccc4(150, 150, 150, 115) width: s.width height: s.height];
        pauseLayer.position = CGPointZero;
        [self addChild: pauseLayer z:8];
    }
        _pauseScreen =[CCSprite spriteWithFile:@"pauseMenu.png"];
        _pauseScreen.position= ccp(s.width/2,(s.height+CurrentAdHeight.height)/2);
        [self addChild:_pauseScreen z:8];
        
        PauseLabel = [CCLabelTTF labelWithString:@"Paused" fontName:@"Danube" fontSize:28];
        [_pauseScreen addChild:PauseLabel];
    PauseLabel.position = ccp(_pauseScreen.contentSize.width/2, _pauseScreen.contentSize.height-(PauseLabel.contentSize.height*.75));
        CCMenuItem *MainMenuItem = [CCMenuItemImage
                                      itemFromNormalImage:@"Pause_button_MainMenu-U.png" selectedImage:@"Pause_button_MainMenu-D.png"
                                      target:self selector:@selector(QMainMenu)];
        CCMenuItem *ResumeMenuItem = [CCMenuItemImage
                                    itemFromNormalImage:@"Pause_button_Resume-U.png" selectedImage:@"Pause_button_Resume-D.png"
                                    target:self selector:@selector(ResumeButtonTapped:)];
        CCMenuItem *LevelSelectMenuItem = [CCMenuItemImage
                                      itemFromNormalImage:@"Pause_button_Level_Select-U.png" selectedImage:@"Pause_button_Level_Select-D.png"
                                      target:self selector:@selector(QLevelSelect)];
        CCMenuItem *WorldSelectMenuItem = [CCMenuItemImage
                                           itemFromNormalImage:@"Pause_button_World_Select-U.png" selectedImage:@"Pause_button_World_Select-D.png"
                                           target:self selector:@selector(QWorldSelect)];
        CCMenuItem *RestartLevelMenuItem = [CCMenuItemImage
                                          itemFromNormalImage:@"Pause_button_Restart_Level-U.png" selectedImage:@"Pause_button_Restart_Level-D.png"
                                          target:self selector:@selector(QRestartLevel)];
        CCMenuItem *StoreMenuItem = [CCMenuItemImage
                                            itemFromNormalImage:@"Pause_button_Store-U.png" selectedImage:@"Pause_button_Store-D.png" disabledImage:@"Pause_button_Store-Dis.png"
                                            target:self selector:@selector(StoreButtonTapped:)];
        
        CCMenuItem *SkipLevelMenuItem = [CCMenuItemImage
                                            itemFromNormalImage:@"Pause_button_Skip-U.png" selectedImage:@"Pause_button_Skip-D.png"
                                                disabledImage:@"Pause_button_Skip-Dis.png" 
                                            target:self selector:@selector(SkipButtonTapped:)];
        _pauseScreenMenu = [CCMenu menuWithItems:MainMenuItem,WorldSelectMenuItem,LevelSelectMenuItem,RestartLevelMenuItem,ResumeMenuItem,StoreMenuItem,SkipLevelMenuItem, nil];
        [_pauseScreenMenu alignItemsVerticallyWithPadding:12];
        _pauseScreenMenu.position = ccp(_pauseScreen.contentSize.width/2,(_pauseScreen.contentSize.height-PauseLabel.contentSize.height)/2);
        //Shuts off store:
        //[StoreMenuItem setIsEnabled:NO];
    int CurrentSkips = [defaults integerForKey:@"AEC0A589A65770421811A7CF3698CB42"];
    
    if(CurrentSkips <= 0)
    {
        [SkipLevelMenuItem setIsEnabled:NO];
    }
    else
    {
        NSLog(@"User has %i Skips remaining", CurrentSkips);
        CCLabelTTF *CurrentAmountOfSkips = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"(%i)",CurrentSkips] fontName:@"Arial" fontSize:18];
        [SkipLevelMenuItem addChild:CurrentAmountOfSkips];
        CurrentAmountOfSkips.position = ccp(SkipLevelMenuItem.contentSize.width*.8, SkipLevelMenuItem.contentSize.height/2);
        CurrentAmountOfSkips.color = ccc3(0, 0, 0);
    }
    [_pauseScreen addChild:_pauseScreenMenu z:10];
}
-(void)StoreButtonTapped:(id)sender{
    [self removeChild:_pauseScreenMenu cleanup:YES];
    [self removeChild:_pauseScreen cleanup:YES];
    _pauseScreen =[CCSprite spriteWithFile:@"pauseMenu.png"];
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    _pauseScreen.position= ccp(s.width/2,(s.height+CurrentAdHeight.height)/2);
    [self addChild:_pauseScreen z:8];
    PauseLabel = [CCLabelTTF labelWithString:@"Store:" fontName:@"Danube" fontSize:28];
    [_pauseScreen addChild:PauseLabel];
    PauseLabel.position = ccp(_pauseScreen.contentSize.width/2, _pauseScreen.contentSize.height-(PauseLabel.contentSize.height*.75));
    
    CCLabelTTF *StoreD1 = [CCLabelTTF labelWithString:@"Help support Señor Fantástico Games" fontName:@"Arial" fontSize:11];
    CCLabelTTF *StoreD2 = [CCLabelTTF labelWithString:@"and Warple, by buying some" fontName:@"Arial" fontSize:11];
    CCLabelTTF *StoreD3 = [CCLabelTTF labelWithString:@"of our paid upgrades/add-ons" fontName:@"Arial" fontSize:11];
    [_pauseScreen addChild:StoreD1];
    [_pauseScreen addChild:StoreD2];
    [_pauseScreen addChild:StoreD3];
    StoreD1.position = ccp(_pauseScreen.contentSize.width/2, _pauseScreen.contentSize.height*.83);
    StoreD2.position = ccp(_pauseScreen.contentSize.width/2, _pauseScreen.contentSize.height*.79);
    StoreD3.position = ccp(_pauseScreen.contentSize.width/2, _pauseScreen.contentSize.height*.75);
    
    CCLabelTTF *GoldenWarple = [CCLabelTTF labelWithString:@"Golden Warple:" fontName:@"Arial" fontSize:15];
    [_pauseScreen addChild:GoldenWarple];
    GoldenWarple.position = ccp(_pauseScreen.contentSize.width*.3,_pauseScreen.contentSize.height*.55);
    GoldenWarple.color = ccc3(255, 223, 0);
    CCMenuItemImage * WarpleGBuy = [CCMenuItemImage itemWithNormalImage:@"Store_button_Buy-U.png" selectedImage:@"Store_button_Buy-D.png" target:self selector:@selector(BuyWGButtonTapped:)];
    CCMenu *WarpleGMBuy = [CCMenu menuWithItems:WarpleGBuy, nil];
    [_pauseScreen addChild:WarpleGMBuy];
    WarpleGMBuy.position = ccp(_pauseScreen.contentSize.width*.8, _pauseScreen.contentSize.height*.55);
    CCLabelTTF *LevelSkips = [CCLabelTTF labelWithString:@"Level Skip X3:" fontName:@"Arial" fontSize:15];
    [_pauseScreen addChild:LevelSkips];
    LevelSkips.position = ccp(_pauseScreen.contentSize.width*.3,_pauseScreen.contentSize.height*.45);
    CCMenuItemImage * LevelSkipsBuy = [CCMenuItemImage itemWithNormalImage:@"Store_button_Buy-U.png" selectedImage:@"Store_button_Buy-D.png" target:self selector:@selector(BuyLevelSkipsButtonTapped:)];
    CCMenu *LevelSkipsMBuy = [CCMenu menuWithItems:LevelSkipsBuy, nil];
    [_pauseScreen addChild:LevelSkipsMBuy];
    LevelSkipsMBuy.position = ccp(_pauseScreen.contentSize.width*.8, _pauseScreen.contentSize.height*.45);
    CCLabelTTF *NoAds = [CCLabelTTF labelWithString:@"Remove Ads:" fontName:@"Arial" fontSize:15];
    [_pauseScreen addChild:NoAds];
    NoAds.position = ccp(_pauseScreen.contentSize.width*.3,_pauseScreen.contentSize.height*.35);
    CCMenuItemImage * NoAdsBuy = [CCMenuItemImage itemWithNormalImage:@"Store_button_Buy-U.png" selectedImage:@"Store_button_Buy-D.png" target:self selector:@selector(BuyNoAds:)];
    CCMenu *NoAdsMBuy = [CCMenu menuWithItems:NoAdsBuy, nil];
    [_pauseScreen addChild:NoAdsMBuy];
    NoAdsMBuy.position = ccp(_pauseScreen.contentSize.width*.8, _pauseScreen.contentSize.height*.35);
    CCMenuItemImage *Back = [CCMenuItemImage itemWithNormalImage:@"Pause_button_Back-U.png" selectedImage:@"Pause_button_Back-D.png" target:self selector:@selector(StoreBackButtonTapped:)];
    CCMenuItemImage *Restore = [CCMenuItemImage itemWithNormalImage:@"Store_button_Restore-U.png" selectedImage:@"Store_button_Restore-D.png" target:self selector:@selector(RestoreButtonTapped:)];
    CCMenu *BackMenu = [CCMenu menuWithItems:Restore,Back, nil];
    [_pauseScreen addChild:BackMenu];
    [BackMenu alignItemsVerticallyWithPadding:10];
    BackMenu.position =ccp(_pauseScreen.contentSize.width/2, _pauseScreen.contentSize.height*.12);
}
-(void)RestoreButtonTapped:(id)sender{
    if([SKPaymentQueue canMakePayments]) {
        
        [[MKStoreManager sharedManager] restorePreviousTransactionsOnComplete:^(void) {
            NSLog(@"Restored.");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your purchases were succesfully restored. Please restart the app." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert setTag:5];
            [alert show];
            /* update views, etc. */
        }
        onError:^(NSError *error) {
        NSLog(@"Restore failed: %@", [error localizedDescription]);
            
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Sorry but we were unable to restore your past purchases. Please try again later" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert setTag:6];
            [alert show];
        }];
    }
    else
    {
        NSLog(@"Parental control enabled");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parental Controls" message:@"Sorry but we were unable to restore your past purchases. Parental controls were enabled. Please turn them off and try again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert setTag:7];
        [alert show];
    }
}
-(void)StoreBackButtonTapped:(id)sender{
    [self removeChild:_pauseScreenMenu cleanup:YES];
    [self removeChild:_pauseScreen cleanup:YES];
    [self PauseButtonTapped];
}
-(void)BuyLevelSkipsButtonTapped:(id)sender{
    [[MKStoreManager sharedManager] buyFeature:@"com.senorfantasticogames.LevelSkipsIAP"
                                    onComplete:^(NSString* purchasedFeature,
                                                 NSData* purchasedReceipt,
                                                 NSArray* availableDownloads)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         [self Unlock3Skips];
     }
     
                                   onCancelled:^
     {
         NSLog(@"User Cancelled Transaction");
     }];
}
-(void)BuyWGButtonTapped:(id)sender{
    CGSize s = [[CCDirector sharedDirector] winSize];
    CCLayer *AppStoreContact = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 200) width: s.width height: s.height];
    AppStoreContact.position = CGPointZero;
    CCLabelTTF *Contact = [CCLabelTTF labelWithString:@"Contacting App Store..." fontName:@"Times New Roman" fontSize:30];
    [self addChild:AppStoreContact z:30];
    [AppStoreContact addChild:Contact];
    Contact.position = ccp(AppStoreContact.contentSize.width/2, AppStoreContact.contentSize.height/2);
    
    [[MKStoreManager sharedManager] buyFeature:@"com.senorfantasticogames.GoldenWarpleIAP"
                                    onComplete:^(NSString* purchasedFeature,
                                                 NSData* purchasedReceipt,
                                                 NSArray* availableDownloads)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         [self removeChild:AppStoreContact cleanup:YES];
         [self UnlockGoldenWarple];
     }
     
    onCancelled:^
     {
         [self removeChild:AppStoreContact cleanup:YES];
         NSLog(@"User Cancelled Transaction");
     }];

}
-(void)BuyNoAds:(id)sender{
    [[MKStoreManager sharedManager] buyFeature:@"com.senorfantasticogames.RemoveAdsIAP"
                                    onComplete:^(NSString* purchasedFeature,
                                                 NSData* purchasedReceipt,
                                                 NSArray* availableDownloads)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         [self UnlockRemoveAds];
     }
     
                                   onCancelled:^
     {
         NSLog(@"User Cancelled Transaction");
     }];
}
-(void)SkipButtonTapped:(id)sender{
    [self removeChild:_pauseScreen cleanup:YES];
    [self removeChild:_pauseScreenMenu cleanup:YES];
    [self removeChild:pauseLayer cleanup:YES];
    GameIsPaused = NO;
    [[CCDirector sharedDirector] resume];
    [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
    _pauseScreenUp=FALSE;
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[SimpleAudioEngine sharedEngine] stopEffect:@"Ticking.caf"];
    
    int CurrentSkips = [defaults integerForKey:@"AEC0A589A65770421811A7CF3698CB42"];
    CurrentSkips = CurrentSkips -1;
    [defaults setInteger:CurrentSkips forKey:@"AEC0A589A65770421811A7CF3698CB42"];
    [defaults synchronize];
    [self HandleFinish:OriganalLevelTime collectedGems:3 OtherGemsCollected:TotalOthers];
}
-(void)LevelSelectButtonTapped{
    [self removeChild:_pauseScreen cleanup:YES];
    [self removeChild:_pauseScreenMenu cleanup:YES];
    [self removeChild:pauseLayer cleanup:YES];
    GameIsPaused = NO;
    [[CCDirector sharedDirector] resume];
    [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
    _pauseScreenUp=FALSE;
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[SimpleAudioEngine sharedEngine] stopEffect:@"Ticking.caf"];
    
    if(PlayersWorld <2){
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:.5 scene:[WorldOneSelectLayer scene]]];
    } else {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:.5 scene:[WorldTwoSelectLayer scene]]];
    }
}
-(void)Unlock3Skips{
    
    int CurrentSkips = [defaults integerForKey:@"AEC0A589A65770421811A7CF3698CB42"];
    CurrentSkips = CurrentSkips + 3;
    [defaults setInteger:CurrentSkips forKey:@"AEC0A589A65770421811A7CF3698CB42"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Thank you for purchasing 3 level skips! We hope they come in handy to you." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert setTag:10];
    [alert show];
}
-(void)UnlockGoldenWarple{
        [defaults setBool:YES forKey:@"8F96C70252ACADF31B4F5A91B2CA425A"];
    
        [[NSUserDefaults standardUserDefaults] synchronize];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Thank you for your purchase of the Golden Warple! Please restart the app for the changes to take effect." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert setTag:8];
    [alert show];
    
}
-(void)UnlockRemoveAds{
        [defaults setBool:YES forKey:@"A0843A138E93C609FC292486D9BB40FE"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Thank you for your purchase. The ads will now be remoeved from your game. Please restart the app for the changes to take effect." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert setTag:9];
    [alert show];
}
-(void)RestartLevelButtonTapped{
    [self removeChild:_pauseScreen cleanup:YES];
    [self removeChild:_pauseScreenMenu cleanup:YES];
    [self removeChild:pauseLayer cleanup:YES];
    GameIsPaused = NO;
    [[CCDirector sharedDirector] resume];
    [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
    _pauseScreenUp=FALSE;
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[SimpleAudioEngine sharedEngine] stopEffect:@"Ticking.caf"];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCW transitionWithDuration:.5 scene:[Game sceneWithLevelData:PlayersLevel mapWorldNum:PlayersWorld]]];
}
-(void)WorldSelectButtonTapped{
    [self removeChild:_pauseScreen cleanup:YES];
    [self removeChild:_pauseScreenMenu cleanup:YES];
    [self removeChild:pauseLayer cleanup:YES];
    GameIsPaused = NO;
    [[CCDirector sharedDirector] resume];
    [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
    _pauseScreenUp=FALSE;
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[SimpleAudioEngine sharedEngine] stopEffect:@"Ticking.caf"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:.5 scene:[WorldSelectLayer scene]]];
}

-(void)ResumeButtonTapped:(id)sender{
    [self removeChild:_pauseScreen cleanup:YES];
    [self removeChild:_pauseScreenMenu cleanup:YES];
    [self removeChild:pauseLayer cleanup:YES];
    GameIsPaused = NO;
    [[CCDirector sharedDirector] resume];
    
    [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [pausebutton setIsEnabled:YES];

    _pauseScreenUp=FALSE;
}
-(void)TimerUpdate:(ccTime)Delta{
    LevelTime--;
    if (LevelTime == 5) {
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:.07];
        [[SimpleAudioEngine sharedEngine] playEffect:@"Ticking.caf"];
    }
    [TimeLabel setString:[NSString stringWithFormat:@"%i",LevelTime]];
    
    
    if (LevelTime <= 0) {
        NSLog(@"DEAD!");
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:1];
        [self unschedule:@selector(TimerUpdate:)];
        [self GameOver];
    }
    
}
-(void)DirectorOveride:(ccTime)Delta{
    if(GameIsPaused){
        NSLog(@"Overrided director unpause");
        [[CCDirector sharedDirector] pause];
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    }
}
- (void) reportAchievementIdentifier: (NSString*) identifier percentComplete: (float) percent
{
    GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier: identifier];
    if (achievement)
    {
        achievement.percentComplete = percent;
        [achievement reportAchievementWithCompletionHandler:^(NSError *error)
         {
             if (error != nil)
             {
                 NSLog(@"WARNING: Achievment:%@ failed to be submitted", achievement);// Retain the achievement object and try again later (not shown).
             } else{
                 NSLog(@"Achievment:%@ was submitted successfully", achievement);
             }
         }];
    }
}
-(void)ReportAndSaveWarps{
    if(TotalWarps ==0){
    TotalWarps = [defaults integerForKey:@"Warps"];
    }
    TotalWarps = TotalWarps +1;
}


-(void)GameUpdate:(ccTime)Delta{
    CGPoint currentpos = _player.position;
    currentpos = [self tileCoordForPositionRay:currentpos];
    currentpos.y =currentpos.y-1;
    if (!isRetina) {
        currentpos.x = currentpos.x/2;
    }
    if (joystick.joystick.velocity.x == 0 && joystick.joystick.velocity.x == 0) {
        //None
        return;
    } else if (joystick.joystick.velocity.x == 1){
        [self MoveCharacter:ccp(currentpos.x+1,currentpos.y) movetype:0];
    } else if (joystick.joystick.velocity.x == -1){
        [self MoveCharacter:ccp(currentpos.x-1,currentpos.y) movetype:0];
    } else if (joystick.joystick.velocity.y == 1){
        [self MoveCharacter:ccp(currentpos.x,currentpos.y-1)movetype:1];
    } else if (joystick.joystick.velocity.y == -1){
        [self MoveCharacter:ccp(currentpos.x,currentpos.y+1)movetype:1];
    }
    
    
}


-(id)initWithLevelData:(int)maplevelNum mapWorldNum:(int)mapWorldNum{
    
    if(self = [super initWithColor:ccc4(255, 255, 255, 0)])
    {
        kGameUpadteTime = .60;
        [self checkfordevicetype];
        GemsGained = 0;
        OtherGems = 0;
        GameIsPaused = NO;
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Ticking.caf"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"PickUp.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Ice_UF.mp3"];
        CGSize winSize = [[CCDirector sharedDirector] winSize]; //Get window Size
        _pauseScreenUp = FALSE;
        //Load Menu Bar
        menubar = [CCSprite spriteWithFile:@"menu.png"];
        menubar.position =ccp(160, winSize.height-20);
        [self addChild:menubar];
        NSString *maptempname = [NSString stringWithFormat:@"level%i_%i.tmx",mapWorldNum,maplevelNum];
        [self GetAndSetMapValues:maptempname];
        
        maplevelDataNum = [NSString stringWithFormat:@"%i - %i",mapWorldNum,maplevelNum];
        NSLog(@"Player is on %@",maplevelDataNum);
        PlayersWorld = mapWorldNum;
        PlayersLevel = maplevelNum;
        CCLabelTTF *levelname = [CCLabelTTF labelWithString:maplevelDataNum fontName:@"BD Cartoon Shout" fontSize:28];
        [menubar addChild:levelname];
        levelname.position =ccp(menubar.contentSize.width/2, menubar.contentSize.height/2);
         pausebutton = [CCMenuItemImage itemWithNormalImage:@"pause_button.png" selectedImage:@"pause_button.png" disabledImage:@"pause_button.png" target:self selector:@selector(PauseButtonTapped)];
        CCMenu *topmenuright = [CCMenu menuWithItems:pausebutton, nil];
        [menubar addChild:topmenuright];
        Gem1 = [CCSprite spriteWithFile:@"Gem-1-D.png"];
        Gem2 = [CCSprite spriteWithFile:@"Gem-1-D.png"];
        Gem3 = [CCSprite spriteWithFile:@"Gem-1-D.png"];
        [menubar addChild:Gem1 z:9 tag:50171];
        [menubar addChild:Gem2 z:8 tag:50172];
        [menubar addChild:Gem3 z:7 tag:50173];
        Gem1.position = ccp(((levelname.position.y + menubar.contentSize.width))/1.5 + Gem1.contentSize.width*1.5, menubar.contentSize.height/2);
        Gem2.position = ccp(Gem1.position.x-Gem2.contentSize.width/2, menubar.contentSize.height/2);
        Gem3.position = ccp(Gem2.position.x-Gem3.contentSize.width/2, menubar.contentSize.height/2);
        topmenuright.position = ccp(winSize.width*.95, menubar.contentSize.height/2);
        
        BOOL *GoldenWarpYN = [defaults boolForKey:@"8F96C70252ACADF31B4F5A91B2CA425A"];
        if (GoldenWarpYN)
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Genie_default_Golden.plist"];
            [[CCAnimationCache sharedAnimationCache] addAnimationsWithFile:@"genie_animation_Golden.plist"];
            _player = [CCSprite spriteWithSpriteFrameName:@"Genie0001.png"];
            CCAnimation *Genie = [[CCAnimationCache sharedAnimationCache] animationByName:@"Genie_Walk"];
            PlayerAnimationRepeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:Genie]];
        }
        else
        {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Genie_default.plist"];
        [[CCAnimationCache sharedAnimationCache] addAnimationsWithFile:@"genie_animation.plist"];
        _player = [CCSprite spriteWithSpriteFrameName:@"Genie0001.png"];
        CCAnimation *Genie = [[CCAnimationCache sharedAnimationCache] animationByName:@"Genie_Walk"];
        PlayerAnimationRepeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:Genie]];
        }
        PlayerAnimationRepeat.tag = 222;
        [_player runAction:PlayerAnimationRepeat];
        [self placePlayerAtSpawn];
        
        if (isRetina) {
            Warp = [CCMenuItemImage itemWithNormalImage:@"Warp-c-u-hd.png" selectedImage:@"Warp-c-d-hd.png" disabledImage:@"Warp-n-u-hd.png" target:self selector:@selector(WarpWarple:)];
                CCMenu *Warpbutton = [CCMenu menuWithItems:Warp, nil];
                Warpbutton.position = ccp(winSize.width/2-80, 130);
            [self addChild:Warpbutton z:-3];
            if(winSize.height != 568){
                Warp.scale = .73;
    
                Warpbutton.position =ccp(winSize.width/2-80, 86);
            }
            
        
        
        } else {
            
            Warp = [CCMenuItemImage itemWithNormalImage:@"Warp-c-u.png" selectedImage:@"Warp-c-d.png" disabledImage:@"Warp-n-u.png" target:self selector:@selector(WarpWarple:)];
            CCMenu *Warpbutton = [CCMenu menuWithItems:Warp, nil];
            Warpbutton.position = ccp(winSize.width/2-80, 85);
            [self addChild:Warpbutton z:-5];
        }
        [self WarpButtonType];
        [self addJoystick];
        [self CountOtherGems];
        [self schedule:@selector(GameUpdate:) interval:kGameUpadteTime];
        [self schedule:@selector(DirectorOveride:) interval:.1];
        self.state= kGameStatePlaying;
        
        
    }
    return self;
}
-(void)CountOtherGems{
    CGPoint myPt;
    for (int x = 0; x < _tileMap.mapSize.width; x++)
    {
        for (int y = 0; y < _tileMap.mapSize.height; y++)
        {
            myPt.x = x;
            myPt.y = y;
            int tileGid_Gem = [_Objects tileGIDAt:myPt];
            if (tileGid_Gem) {
                NSDictionary *properties = [_tileMap propertiesForGID:tileGid_Gem];
                if (properties) {
                    NSString *Gem = [properties valueForKey:@"Other"];
                    if (Gem && [Gem compare:@"True"] == NSOrderedSame) {
                        TotalOthers++;
                    }
                }
            }
        }
    }
}
-(void)placePlayerAtSpawn{
    CCTMXObjectGroup *points = [_tileMap objectGroupNamed:@"Points"];//Get Object group
    NSAssert(points !=nil, @"'Points' object group not found");
    NSMutableDictionary *spawnpoint = [points objectNamed:@"SpawnPoint"];//Find Spawn Point
    NSAssert(spawnpoint !=nil, @"SpawnPoint object not found");
    int mult = 1;
    if(!isRetina)
    {
        mult = 2;
    }
    int x = [[spawnpoint valueForKey:@"x"] intValue];
    int y = [[spawnpoint valueForKey:@"y"] intValue];
    _player.anchorPoint = ccp(0,0);
    _player.position = ccp([self tileCoordForPosition:ccp(x, y)].x*(29*mult), (_tileMap.mapSize.height - [self tileCoordForPosition:ccp(x, y)].y)*(29*mult));
    [_tileMap addChild:_player z:1 tag:5017];
}
-(void)SetLevelTimer:(CCTMXTiledMap *)LevelMap{
    NSDictionary *properties = [LevelMap properties];
    NSString * time = [properties valueForKey:@"Time"];
    LevelTime = [time intValue];
    OriganalLevelTime = LevelTime;
    NSLog(@"%@",time);
    
    TimeLabel = [CCLabelTTF labelWithString:time fontName:@"Ticking Timebomb BB" fontSize:30];
    [menubar addChild:TimeLabel];
    TimeLabel.position = ccp(menubar.contentSize.width*.1, menubar.contentSize.height/2);
    [self schedule:@selector(TimerUpdate:) interval:1];
}


-(void)GetAndSetMapValues:(NSString *)FileName{
    self.tilemap = [CCTMXTiledMap tiledMapWithTMXFile:FileName];//Load Tile Map
    self.background = [_tileMap layerNamed:@"Background"]; // Set background layer
    self.puzzle = [_tileMap layerNamed:@"Puzzle"];
    self.Objects = [_tileMap layerNamed:@"Objects"];
    self.NoWarps = [_tileMap layerNamed:@"NoWarps"];
    CGSize winSize = [[CCDirector sharedDirector] winSize]; //Get window Size
    // Position Map
    if (!isRetina)//Check For Retina
    {
        _tileMap.scale = .5;
    }
    _tileMap.position = ccp(0, winSize.height-358);
    [self addChild:_tileMap z:-1];//Add map
    [self SetLevelTimer:_tileMap];
}
-(void)adWhirlWillPresentFullScreenModal {
    if (self.state == kGameStatePlaying) {
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        [[CCDirector sharedDirector] pause];
    }
}
-(void)adWhirlDidDismissFullScreenModal {
    if(_pauseScreenUp == FALSE){
        [[CCDirector sharedDirector] resume];
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        self.state = kGameStatePlaying;
    }
}
- (NSString *)adWhirlApplicationKey {
    return @"1c97032af27c424ea2fc0b3dd599dd41";
}
- (UIViewController *)viewControllerForPresentingModalView {
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    UINavigationController *viewController = [app navController];
    return viewController;
}
-(void)adjustAdSize {
    [UIView beginAnimations:@"AdResize" context:nil];
    [UIView setAnimationDuration:0.2];
    CGSize adSize = [adWhirlView actualAdSize];
    CurrentAdHeight = adSize;
    CGRect newFrame = adWhirlView.frame;
    newFrame.size.height = adSize.height;
    CGSize winSize = [CCDirector sharedDirector].winSize;
    newFrame.size.width = winSize.width;
    newFrame.origin.x = (self.adWhirlView.bounds.size.width - adSize.width)/2;
    newFrame.origin.y = (winSize.height -adSize.height);
    adWhirlView.frame = newFrame;
    [UIView commitAnimations];
    NSLog(@"Ad from:%@",[adWhirlView mostRecentNetworkName]);
}
-(void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlVieww {
    [adWhirlVieww rotateToOrientation:UIInterfaceOrientationPortraitUpsideDown];
    [self adjustAdSize];
}
-(void)onEnter {
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    viewController = [app navController];
    self.adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    //self.adWhirlView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [adWhirlView updateAdWhirlConfig];
    CGSize adSize = [adWhirlView actualAdSize];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    self.adWhirlView.frame = CGRectMake((winSize.width/2)-(adSize.width/2), winSize.height-adSize.height, winSize.width, adSize.height);
    self.adWhirlView.clipsToBounds = YES;
    defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:@"A0843A138E93C609FC292486D9BB40FE"]) {
        NSLog(@"No Ads for this awesome guy!");
        CCSprite *Adreplacement = [CCSprite spriteWithFile:@"AdReplace.png"];
        [self addChild:Adreplacement z:30];
        Adreplacement.position = ccp(winSize.width/2, Adreplacement.contentSize.height/2);
    } else {
    [viewController.view addSubview:adWhirlView];
    [viewController.view bringSubviewToFront:adWhirlView];
    }
    [super onEnter];
}
-(void)onExit {
    
    if(adWhirlView) {
        [adWhirlView removeFromSuperview];
        [adWhirlView replaceBannerViewWith:nil];
        [adWhirlView ignoreNewAdRequests];
        [adWhirlView setDelegate:nil];
        self.adWhirlView = nil;
    }
    [super onExit];
}
@end
