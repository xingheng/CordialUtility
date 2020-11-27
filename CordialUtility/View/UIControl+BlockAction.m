//
//  UIControl+BlockAction.m
//
//  Created by WeiHan on 5/26/17.
//

#import "UIControl+BlockAction.h"
@import ObjectiveC.runtime;

NSString * NameFromControlEvent(UIControlEvents event)
{
#define ENUM_START  \
    NSString * ret; \
    switch (event) {
#define ENUM_CASE(evalue) \
    case evalue:          \
        ret = @#evalue;   \
        break;

#define ENUM_END \
    }            \
    return ret;

    ENUM_START
        ENUM_CASE(UIControlEventTouchDown)
    ENUM_CASE(UIControlEventTouchDownRepeat)
    ENUM_CASE(UIControlEventTouchDragInside)
    ENUM_CASE(UIControlEventTouchDragOutside)
    ENUM_CASE(UIControlEventTouchDragEnter)
    ENUM_CASE(UIControlEventTouchDragExit)
    ENUM_CASE(UIControlEventTouchUpInside)
    ENUM_CASE(UIControlEventTouchUpOutside)
    ENUM_CASE(UIControlEventTouchCancel)
    ENUM_CASE(UIControlEventValueChanged)
    ENUM_CASE(UIControlEventPrimaryActionTriggered)
    ENUM_CASE(UIControlEventEditingDidBegin)
    ENUM_CASE(UIControlEventEditingChanged)
    ENUM_CASE(UIControlEventEditingDidEnd)
    ENUM_CASE(UIControlEventEditingDidEndOnExit)
    ENUM_CASE(UIControlEventAllTouchEvents)
    ENUM_CASE(UIControlEventAllEditingEvents)
    ENUM_CASE(UIControlEventApplicationReserved)
    ENUM_CASE(UIControlEventSystemReserved)
    ENUM_CASE(UIControlEventAllEvents)
    ENUM_END
}

@interface UIControl (_BlockAction)

@property (nonatomic, strong) NSMutableDictionary *dictEventBlock;

@end

@implementation UIControl (BlockAction)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
#pragma clang diagnostic ignored "-Wunguarded-availability-new"
#pragma clang diagnostic ignored "-Wunsupported-availability-guard"

#pragma mark - Public

- (void)addEventBlock:(EventActionBlockType)block forControlEvents:(UIControlEvents)controlEvents
{
    NSArray<NSNumber *> *allEventTypes = @[
        @(UIControlEventTouchDown),
        @(UIControlEventTouchDownRepeat),
        @(UIControlEventTouchDragInside),
        @(UIControlEventTouchDragOutside),
        @(UIControlEventTouchDragEnter),
        @(UIControlEventTouchDragExit),
        @(UIControlEventTouchUpInside),
        @(UIControlEventTouchUpOutside),
        @(UIControlEventTouchCancel),
        @(UIControlEventValueChanged),
        @(@available(iOS 9.0, *) ? UIControlEventPrimaryActionTriggered : 0),
        @(UIControlEventEditingDidBegin),
        @(UIControlEventEditingChanged),
        @(UIControlEventEditingDidEnd),
        @(UIControlEventEditingDidEndOnExit),
        @(UIControlEventAllTouchEvents),
        @(UIControlEventAllEditingEvents),
        @(UIControlEventApplicationReserved),
        @(UIControlEventSystemReserved),
    ];

    for (NSUInteger idx = 0; idx < allEventTypes.count; idx++) {
        UIControlEvents event = allEventTypes[idx].unsignedIntegerValue;

        if (event & controlEvents) {
            NSString *strSelector = [NSString stringWithFormat:@"bk_controlEventHandlerAction_%@:", NameFromControlEvent(event)];
            SEL selector = NSSelectorFromString(strSelector);

            if (selector) {
                [self addTarget:self action:selector forControlEvents:event];

                if (!self.dictEventBlock) {
                    self.dictEventBlock = [NSMutableDictionary new];
                }

                self.dictEventBlock[NSStringFromSelector(selector)] = block;
            } else {
                NSLog(@"Selector not found: %@", strSelector);
            }

            controlEvents ^= event;

            if (controlEvents == 0) {
                break;
            }

            // idx = 0;
        }
    }
}

#pragma mark - Action

#define DEFINEACTION(_EVENT_)                                                             \
    - (void)bk_controlEventHandlerAction_ ## _EVENT_:(id)sender                           \
    {                                                                                     \
        if (self.allControlEvents & _EVENT_) {                                            \
            EventActionBlockType block = self.dictEventBlock[NSStringFromSelector(_cmd)]; \
            !block ? : block(sender);                                                     \
        }                                                                                 \
    }

DEFINEACTION(UIControlEventTouchDown)
DEFINEACTION(UIControlEventTouchDownRepeat)
DEFINEACTION(UIControlEventTouchDragInside)
DEFINEACTION(UIControlEventTouchDragOutside)
DEFINEACTION(UIControlEventTouchDragEnter)
DEFINEACTION(UIControlEventTouchDragExit)
DEFINEACTION(UIControlEventTouchUpInside)
DEFINEACTION(UIControlEventTouchUpOutside)
DEFINEACTION(UIControlEventTouchCancel)
DEFINEACTION(UIControlEventValueChanged)
DEFINEACTION(UIControlEventPrimaryActionTriggered)
DEFINEACTION(UIControlEventEditingDidBegin)
DEFINEACTION(UIControlEventEditingChanged)
DEFINEACTION(UIControlEventEditingDidEnd)
DEFINEACTION(UIControlEventEditingDidEndOnExit)
DEFINEACTION(UIControlEventAllTouchEvents)
DEFINEACTION(UIControlEventAllEditingEvents)
DEFINEACTION(UIControlEventApplicationReserved)
DEFINEACTION(UIControlEventSystemReserved)

#pragma mark - Property

- (void)setDictEventBlock:(NSMutableDictionary *)dictEventBlock
{
    objc_setAssociatedObject(self, @selector(dictEventBlock), dictEventBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)dictEventBlock
{
    return objc_getAssociatedObject(self, @selector(dictEventBlock));
}

#pragma clang diagnostic pop

@end
