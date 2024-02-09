#import <YandexMapsMobile/YRTExport.h>

#import <Foundation/Foundation.h>

/**
 * Result display type.
 */
typedef NS_ENUM(NSUInteger, YMKSearchDisplayType) {
    /**
     * Each result makes sense without the others (i.e. toponyms), they
     * probably shouldn'be displayed as a group, and probably there's no
     * need to make additional requests after user moves the map or zooms in
     * or out.
     */
    YMKSearchDisplayTypeSingle,
    /**
     * Results are meaningful as a group (i.e. category query), they should
     * be displayed all together, and it makes sense to send additional
     * requests after user changes visible map region.
     */
    YMKSearchDisplayTypeMultiple
};
