//  Created by Andrey Ostanin on 13.03.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#ifndef XZDefaults_h
#define XZDefaults_h

/**
 *  Macros for configuring DataLayerViewer with default supplied 
 *  store component
 *
 */
#define XZDefaultStore [XZMemoryEventsHistoryStore class]

/**
 *  Macros for configuring DataLayerViewer with default supplied
 *  event generator component wich generates events on every push
 *	to Google Tag Manager data layer
 */
#define XZDefaultObserver [XZDataLayerObserver class]

#endif /* Defaults_h */
