#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YMKMasstransitJamType.h>
#import <YandexMapsMobile/YMKPolyline.h>
#import <YandexMapsMobile/YRTExport.h>

#import <UIKit/UIKit.h>

@class YMKMasstransitJamStyle;
@class YMKMasstransitRoute;
@class YMKMasstransitRoutePainter;

/**
 * Color for a specific level of traffic intensity.
 */
YRT_EXPORT @interface YMKMasstransitJamTypeColor : NSObject

/**
 * The type of traffic jam.
 */
@property (nonatomic, readonly) YMKMasstransitJamType jamType;

/**
 * Traffic jam color.
 */
@property (nonatomic, readonly, nonnull) UIColor *jamColor;


+ (nonnull YMKMasstransitJamTypeColor *)jamTypeColorWithJamType:( YMKMasstransitJamType)jamType
                                                       jamColor:(nonnull UIColor *)jamColor;


@end

/**
 * The style that is used to display traffic intensity.
 */
YRT_EXPORT @interface YMKMasstransitJamStyle : NSObject

/**
 * Collection of colors for traffic intensity.
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKMasstransitJamTypeColor *> *colors;

/**
 * The color of segments for which traffic intensity makes no sense
 * (e.g. underground).
 */
@property (nonatomic, readonly, nonnull) UIColor *noJamColor;


+ (nonnull YMKMasstransitJamStyle *)jamStyleWithColors:(nonnull NSArray<YMKMasstransitJamTypeColor *> *)colors
                                            noJamColor:(nonnull UIColor *)noJamColor;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKMasstransitJamUtils : NSObject

/**
 * Creates a default traffic style. Default values: colors : Unknown  :
 * 0xccccccff, Blocked  : 0x000000ff, Free     : 0x38c724ff, Light    :
 * 0xf8dd40ff, Hard     : 0xfa5728ff, VeryHard : 0xac3818ff,
 */
+ (nonnull YMKMasstransitJamStyle *)createDefaultJamStyle;

/**
 * Creates a style for disabled traffic. Colors : Unknown  : 0x6756edff,
 * Blocked  : 0x6756edff, Free     : 0x6756edff, Light    : 0x6756edff,
 * Hard     : 0x6756edff, VeryHard : 0x6756edff,
 */
+ (nonnull YMKMasstransitJamStyle *)createDisabledJamStyle;

/**
 * Applies the traffic style. Updates colors for traffic types provided
 * in the style parameter. The default color is 0xffffffff.
 *
 * The method calls only the following polyline methods: -
 * setPaletteColor
 */
+ (void)applyJamStyleWithPolyline:(nonnull YMKPolylineMapObject *)polyline
                            style:(nonnull YMKMasstransitJamStyle *)style;

/**
 * Undocumented
 */
+ (nonnull YMKMasstransitRoutePainter *)createRoutePainter;

@end


/**
 * Makes it easy to paint PolylineMapObject in route traffic colors.
 *
 * Do this in two steps: 1. Initialize the painter. Set the traffic
 * style you want and the route for the painter to use to get info about
 * traffic intensity. 2. Choose any subpolyline of the route's geometry
 * and give it to the painter along with the PolylineMapObject you want
 * to paint. The painter will set the geometry of the map object to that
 * of the chosen subpolyline and assign colors for any of its segments.
 *
 * You can assign other routes to the painter. But make sure that the
 * subpolyline you give to the painter afterwards corresponds to the set
 * route's geometry, otherwise the painter will crash.
 */
YRT_EXPORT @interface YMKMasstransitRoutePainter : NSObject

/**
 * Sets the current style.
 */
- (void)setJamStyleWithStyle:(nonnull YMKMasstransitJamStyle *)style;

/**
 * Resets colors according to the current traffic intensity on the
 * route.
 */
- (void)resetWithRoute:(nonnull YMKMasstransitRoute *)route;

/**
 * Sets a new geometry and colors for a polyline.
 *
 * The method calls only the following methods of a polyline: -
 * setGeometry - setColors - setPaletteColor
 */
- (void)updatePolylineWithPolyline:(nonnull YMKPolylineMapObject *)polyline
                       subpolyline:(nonnull YMKSubpolyline *)subpolyline;

@end
