//
//  GameOverLayer.h
//  Warple
//
//  Created by Marc Frankel on 3/6/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor {
    int PlayersLevel;
    int PlayerWorld;
}

+(CCScene *) sceneWithLevelData:(int)mapName mapWorldNum:(int)mapWorldnum;
- (id)initWithLevelData:(int)maplevelNum mapWorldNum:(int)mapWorldNum;
@end
