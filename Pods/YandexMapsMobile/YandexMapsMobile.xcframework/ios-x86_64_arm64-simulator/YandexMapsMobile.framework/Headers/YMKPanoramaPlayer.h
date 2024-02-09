#import <YandexMapsMobile/YMKDirection.h>
#import <YandexMapsMobile/YMKLogo.h>
#import <YandexMapsMobile/YMKPanoramaPanoramaDescription.h>
#import <YandexMapsMobile/YMKPoint.h>
#import <YandexMapsMobile/YMKSpan.h>
#import <YandexMapsMobile/YRTExport.h>

@class YMKCompanyTapInfo;
@class YMKHistoricalPanorama;
@class YMKPanoramaPlayer;

/**
 * Listener to handle the panorama being opened or changed.
 */
@protocol YMKPanoramaChangeDelegate <NSObject>

/**
 * Called if the panorama was opened or changed by the user. You can get
 * the panoramaId by using the panoramaId() method.
 *
 * @param player Panorama player that sent the event.
 */
- (void)onPanoramaChangedWithPlayer:(nonnull YMKPanoramaPlayer *)player;

@end

/**
 * Listener to handle the change in panorama direction.
 */
@protocol YMKPanoramaDirectionChangeDelegate <NSObject>

/**
 * Called if the panorama direction was changed by the user or by the
 * setDirection() method.
 *
 * @param player Panorama player that sent the event.
 */
- (void)onPanoramaDirectionChangedWithPlayer:(nonnull YMKPanoramaPlayer *)player;

@end

/**
 * Listener to handle the change in panorama span.
 */
@protocol YMKPanoramaSpanChangeDelegate <NSObject>

/**
 * Called if the user changed the zoom level or the span has been
 * changed by the setSpan() method.
 *
 * @param player Panorama player that sent the event.
 */
- (void)onPanoramaSpanChangedWithPlayer:(nonnull YMKPanoramaPlayer *)player;

@end

/**
 * Listener to handle the taps on company text and icon.
 */
@protocol YMKPanoramaCompanyTapDelegate <NSObject>

/**
 * Called if the user tapped on company icon or text below it.
 *
 * @param player Panorama player that sent the event.
 * @param info Information about tapped company.
 */
- (void)onCompanyTapWithPlayer:(nonnull YMKPanoramaPlayer *)player
                          info:(nonnull YMKCompanyTapInfo *)info;

@end

/**
 * Listener to handle possible errors.
 */
@protocol YMKPanoramaErrorDelegate <NSObject>

/**
 * Error notification listener for the panoramaOpen class. Called if the
 * panorama could not be opened.
 */
- (void)onPanoramaOpenErrorWithPlayer:(nonnull YMKPanoramaPlayer *)player
                                error:(nonnull NSError *)error;

@end

/**
 * Panorama player that is used to open panoramas.
 */
YRT_EXPORT @interface YMKPanoramaPlayer : NSObject

/**
 * Opens the panorama with the given ID.
 *
 * @param panoramaId The panoramaId that specifies the panorama to open.
 * You can get the panoramaId by using the PanoramaService methods.
 */
- (void)openPanoramaWithPanoramaId:(nonnull NSString *)panoramaId;

/**
 * Opens the panorama from the local datasource.
 *
 * @param panoramaDescription Initialize this struct to open panorama
 * @param tileImageProvider The tile datasource
 * @param iconImageProvider The icon datasource
 * @param userPanoramaEventListener The user panorama notification
 * listener
 */
- (void)openUserPanoramaWithLocalDataSourceWithPanoramaDescription:(nonnull YMKPanoramaPanoramaDescription *)panoramaDescription
                                                 tileImageProvider:(nonnull id<YMKPanoramaTileImageFactory>)tileImageProvider
                                                 iconImageProvider:(nonnull id<YMKPanoramaIconImageFactory>)iconImageProvider
                                         userPanoramaEventListener:(nonnull id<YMKPanoramaUserPanoramaDelegate>)userPanoramaEventListener;

/**
 * Opens the panorama from the network datasource.
 *
 * @param panoramaDescription Initialize this struct to open panorama
 * @param tileUrlProvider The network tile datasource
 * @param iconUrlProvider The netwokr icon datasource
 * @param userPanoramaEventListener The user panorama notification
 * listener
 */
- (void)openUserPanoramaWithNetworkDataSourceWithPanoramaDescription:(nonnull YMKPanoramaPanoramaDescription *)panoramaDescription
                                                     tileUrlProvider:(nonnull id<YMKPanoramaTileUrlProvider>)tileUrlProvider
                                                     iconUrlProvider:(nonnull id<YMKPanoramaIconUrlProvider>)iconUrlProvider
                                           userPanoramaEventListener:(nonnull id<YMKPanoramaUserPanoramaDelegate>)userPanoramaEventListener;

/**
 * Opened the panorama with the given ID.
 *
 * @return PanoramaId of the currently opened panorama. Empty if no
 * panorama is open.
 */
- (nonnull NSString *)panoramaId;

/**
 * Geo position of current panorama.
 *
 * @return Geo position of the currently opened panorama. Empty if no
 * panorama is open.
 */
- (nonnull YMKPoint *)position;

/**
 * Sets the view direction to the center of the given geo position.
 *
 * @param position The position to look at.
 */
- (void)lookAtWithPosition:(nonnull YMKPoint *)position;

/**
 * View direction of the opened panorama.
 *
 * @return View direction of the opened panorama. Empty if no panorama
 * is open.
 */
- (nonnull YMKDirection *)direction;

/**
 * Sets the view direction bearing and tilt.
 *
 * @param direction View direction.
 */
- (void)setDirectionWithDirection:(nonnull YMKDirection *)direction;

/**
 * View span of the opened panorama.
 *
 * @return Current view span of the opened panorama. May be different
 * from the span provided by the setSpan(span) method.
 */
- (nonnull YMKSpan *)span;

/**
 * Sets the view area span. Invalid values are adjusted by the player to
 * the closest valid values.
 *
 * @param span View area span. May be adjusted by the player.
 */
- (void)setSpanWithSpan:(nonnull YMKSpan *)span;

/**
 * Closes the opened panorama and stops all player actions.
 */
- (void)reset;

/**
 * @return panoramas published earlier at the current panorama position.
 * Result is updated on the PanoramaChangeListener callback
 */
- (nonnull NSArray<YMKHistoricalPanorama *> *)historicalPanoramas;

/**
 * Enables player zoom controls.
 */
- (void)enableZoom;

/**
 * Disables player zoom controls.
 */
- (void)disableZoom;

/**
 * Checks if zoom controls are enabled.
 */
- (BOOL)zoomEnabled;

/**
 * Shows transition arrows and allows switching panoramas.
 */
- (void)enableMove;

/**
 * Hides transition arrows and disallows switching panoramas.
 */
- (void)disableMove;

/**
 * Checks if switching panoramas is enabled.
 */
- (BOOL)moveEnabled;

/**
 * Allows the user to rotate panoramas.
 */
- (void)enableRotation;

/**
 * Disallows the user to rotate panoramas.
 */
- (void)disableRotation;

/**
 * Checks if player rotation is enabled.
 */
- (BOOL)rotationEnabled;

/**
 * Allows markers (house numbers, railway stations, airports) to be
 * shown.
 */
- (void)enableMarkers;

/**
 * Disallows markers (house numbers, railway stations, airports) to be
 * shown.
 */
- (void)disableMarkers;

/**
 * Checks if markers are enabled.
 */
- (BOOL)markersEnabled;

/**
 * Allows companies (company names and icons) to be shown.
 */
- (void)enableCompanies;

/**
 * Disallows companies (company names and icons) to be shown.
 */
- (void)disableCompanies;

/**
 * Checks if companies are enabled.
 */
- (BOOL)companiesEnabled;

/**
 * Adds a panorama change listener.
 *
 * @param panoramaChangeListener Panorama change listener.
 */
- (void)addPanoramaChangeListenerWithPanoramaChangeListener:(nonnull id<YMKPanoramaChangeDelegate>)panoramaChangeListener;

/**
 * Removes the panorama change listener.
 *
 * @param panoramaChangeListener The panorama change listener to remove.
 */
- (void)removePanoramaChangeListenerWithPanoramaChangeListener:(nonnull id<YMKPanoramaChangeDelegate>)panoramaChangeListener;

/**
 * Adds direction listener.
 *
 * @param directionChangeListener Panorama direction listener.
 */
- (void)addDirectionChangeListenerWithDirectionChangeListener:(nonnull id<YMKPanoramaDirectionChangeDelegate>)directionChangeListener;

/**
 * Removes the direction listener.
 *
 * @param directionChangeListener The panorama direction listener to
 * remove.
 */
- (void)removeDirectionChangeListenerWithDirectionChangeListener:(nonnull id<YMKPanoramaDirectionChangeDelegate>)directionChangeListener;

/**
 * Adds span listener.
 *
 * @param spanChangeListener Panorama span listener.
 */
- (void)addSpanChangeListenerWithSpanChangeListener:(nonnull id<YMKPanoramaSpanChangeDelegate>)spanChangeListener;

/**
 * Removes span listener.
 *
 * @param spanChangeListener The span listener to remove.
 */
- (void)removeSpanChangeListenerWithSpanChangeListener:(nonnull id<YMKPanoramaSpanChangeDelegate>)spanChangeListener;

/**
 * Adds company tap listener.
 *
 * @param companyTapListener Company tap listener.
 */
- (void)addCompanyTapListenerWithCompanyTapListener:(nonnull id<YMKPanoramaCompanyTapDelegate>)companyTapListener;

/**
 * Removes company tap listener.
 *
 * @param companyTapListener The company tap listener to remove.
 */
- (void)removeCompanyTapListenerWithCompanyTapListener:(nonnull id<YMKPanoramaCompanyTapDelegate>)companyTapListener;

/**
 * Adds error listener.
 *
 * @param errorListener Listeners that notify when a panorama failed to
 * open.
 */
- (void)addErrorListenerWithErrorListener:(nonnull id<YMKPanoramaErrorDelegate>)errorListener;

/**
 * Removes error listener.
 *
 * @param errorListener The listener to remove.
 */
- (void)removeErrorListenerWithErrorListener:(nonnull id<YMKPanoramaErrorDelegate>)errorListener;

/**
 * Allows showing loading wheels.
 */
- (void)enableLoadingWheel;

/**
 * Disallows showing loading wheels.
 */
- (void)disableLoadingWheel;

/**
 * Checks if loading wheels can be shown while the panorama is opening.
 */
- (BOOL)loadingWheelEnabled;
/**
 * Yandex logo object.
 */
@property (nonatomic, readonly, readonly, nonnull) YMKLogo *logo;

/**
 * Called when a memory warning happens.
 */
- (void)onMemoryWarning;

/**
 * Tells if this object is valid or no. Any method called on an invalid
 * object will throw an exception. The object becomes invalid only on UI
 * thread, and only when its implementation depends on objects already
 * destroyed by now. Please refer to general docs about the interface for
 * details on its invalidation.
 */
@property (nonatomic, readonly, getter=isValid) BOOL valid;

@end
