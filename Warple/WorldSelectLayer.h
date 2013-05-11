//
//  WorldSelectLayer.h
//  Warple
//
//  Created by Marc Frankel on 1/29/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WorldSelectLayer : CCLayerColor <UIGestureRecognizerDelegate> {
    CCMenuItem *World2;
    
    UISwipeGestureRecognizer * _swipeRightRecognizer;
    
}

+(CCScene *) scene;

@property (strong) UISwipeGestureRecognizer * swipeRightRecognizer;

@end
