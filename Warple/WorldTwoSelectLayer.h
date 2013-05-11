//
//  WorldTwoSelectLayer.h
//  Warple
//
//  Created by Marc Frankel on 3/5/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WorldTwoSelectLayer : CCLayerColor <UIGestureRecognizerDelegate> {
    
    UISwipeGestureRecognizer * _swipeRightRecognizer;
    
}

+(CCScene *) scene;

@property (strong) UISwipeGestureRecognizer * swipeRightRecognizer;
@end