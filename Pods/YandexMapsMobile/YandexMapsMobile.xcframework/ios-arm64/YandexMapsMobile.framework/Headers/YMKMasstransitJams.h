#import <YandexMapsMobile/YMKMasstransitJamType.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * A listener to monitor changes in traffic on the route.
 */
@protocol YMKMasstransitJamsListener <NSObject>

/**
 * Triggers when traffic levels are updated.
 */
- (void)onJamsUpdated;

/**
 * Triggers when traffic levels are outdated.
 */
- (void)onJamsOutdated;

@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKMasstransitJams : NSObject
/**
 * Traffic intensity on a route.
 */
@property (nonatomic, readonly, nonnull) NSArray<NSNumber *> *segments;
/**
 * Indicates whether traffic levels have become outdated when we are not
 * able to fetch updates for some predefined time.
 */
@property (nonatomic, readonly, getter=isOutdated) BOOL outdated;

/**
 * Adds a listener for changes to traffic on the route.
 */
- (void)addListenerWithJamsListener:(nonnull id<YMKMasstransitJamsListener>)jamsListener;

/**
 * Removes the listener for changes to traffic on the route.
 */
- (void)removeListenerWithJamsListener:(nonnull id<YMKMasstransitJamsListener>)jamsListener;

@end
