import Foundation
import Vapor

public struct DynamicLinkRequest: FirebaseRequestModel {

    public let dynamicLinkInfo: DynamicLink
    public let suffix: Suffix

    public init(dynamicLink: DynamicLink, suffix: Suffix) {
        self.dynamicLinkInfo = dynamicLink
        self.suffix = suffix
    }
    
    public struct DynamicLink: FirebaseRequestModel {
        
        public let domainUriPrefix: URL?
        public let link: URL
        public let androidInfo: Android?
        public let iosInfo: Ios?
        public let navigationInfo: Navigation?
        public let analyticsInfo: Analytics?
        public let socialMetaTagInfo: SocialMetaTag?
        
        public init(domainUriPrefix: URL? = nil,
                    link: URL,
                    androidInfo: Android? = nil,
                    iosInfo: Ios? = nil,
                    navigationInfo: Navigation? = nil,
                    analyticsInfo: Analytics? = nil,
                    socialMetaTagInfo: SocialMetaTag? = nil) {
            
            self.domainUriPrefix = domainUriPrefix
            self.link = link
            self.androidInfo = androidInfo
            self.iosInfo = iosInfo
            self.navigationInfo = navigationInfo
            self.analyticsInfo = analyticsInfo
            self.socialMetaTagInfo = socialMetaTagInfo
        }
        
        public struct Android: FirebaseRequestModel {
            
            public let androidPackageName: String
            public let androidFallbackLink: URL?
            public let androidMinPackageVersionCode: String?
            
            public init(packageName: String,
                        fallbackLink: URL? = nil,
                        minPackageVersionCode: String? = nil) {
                
                self.androidPackageName = packageName
                self.androidFallbackLink = fallbackLink
                self.androidMinPackageVersionCode = minPackageVersionCode
            }
        }
        
        public struct Ios: FirebaseRequestModel {
            
            public let iosBundleId: String
            public let iosAppStoreId: String
            public let iosFallbackLink: URL?
            public let iosCustomScheme: String?
            public let iosIpadFallbackLink: URL?
            public let iosIpadBundleId: String?
            
            public init(bundleId: String,
                        appStoreId: String,
                        fallbackLink: URL? = nil,
                        customScheme: String? = nil,
                        ipadFallbackLink: URL? = nil,
                        ipadBundleId: String? = nil) {
                
                self.iosBundleId = bundleId
                self.iosAppStoreId = appStoreId
                self.iosFallbackLink = fallbackLink
                self.iosCustomScheme = customScheme
                self.iosIpadFallbackLink = ipadFallbackLink
                self.iosIpadBundleId = ipadBundleId
            }
        }
        
        public struct Navigation: FirebaseRequestModel {
            
            public let enableForcedRedirect: Bool
            
            public init(enableForcedRedirect: Bool) {
                self.enableForcedRedirect = enableForcedRedirect
            }
        }
        
        public struct Analytics: FirebaseRequestModel {
            
            public let googlePlayAnalytics: GooglePlay?
            public let itunesConnectAnalytics: ItunesConnect?
            
            public init(googlePlay: GooglePlay? = nil,
                        itunesConnect: ItunesConnect? = nil) {
                self.googlePlayAnalytics = googlePlay
                self.itunesConnectAnalytics = itunesConnect
            }
            
            public struct GooglePlay: FirebaseRequestModel {
                
                public let utmSource: String
                public let utmMedium: String
                public let utmCampaign: String
                public let utmTerm: String
                public let utmContent: String
                public let gclid: String
                
                public init(utmSource: String,
                            utmMedium: String,
                            utmCampaign: String,
                            utmTerm: String,
                            utmContent: String,
                            gclid: String) {
                    
                    self.utmSource = utmSource
                    self.utmMedium = utmMedium
                    self.utmCampaign = utmCampaign
                    self.utmTerm = utmTerm
                    self.utmContent = utmContent
                    self.gclid = gclid
                }
            }
            
            public struct ItunesConnect: FirebaseRequestModel, Decodable {
                
                public let affiliateToken: String
                public let campaignText: String
                public let mediaType: ITCMediaType
                public let providerToken: String
                
                public init(affiliateToken: String,
                            campaignText: String,
                            mediaType: ITCMediaType,
                            providerToken: String) {
                    
                    self.affiliateToken = affiliateToken
                    self.campaignText = campaignText
                    self.mediaType = mediaType
                    self.providerToken = providerToken
                }
                
                enum CodingKeys: String, CodingKey {
                    case affiliateToken = "at"
                    case campaignText = "ct"
                    case mediaType = "mt"
                    case providerToken = "pt"
                }
                
                public enum ITCMediaType: Int, Codable {
                    case music = 1
                    case podcasts = 2
                    case audiobooks = 3
                    case tvShows = 4
                    case musicVideos = 5
                    case movies = 6
                    case iPodGames = 7
                    case mobileSoftwareApplications = 8
                    case ringtones = 9
                    case itunesU = 10
                    case eBooks = 11
                    case desktopApps = 12
                }
            }
        }
        
        public struct SocialMetaTag: FirebaseRequestModel {
            
            public let socialTitle: String
            public let socialDescription: String
            public let socialImageLink: URL
            
            public init(socialTitle: String,
                        socialDescription: String,
                        socialImageLink: URL) {
                
                self.socialTitle = socialTitle
                self.socialDescription = socialDescription
                self.socialImageLink = socialImageLink
            }
        }
    }
    
    public struct Suffix: FirebaseRequestModel {
        
        public enum Option: String, FirebaseRequestModel {
            case SHORT
            case UNGUESSABLE
        }
        
        public let option: Option
        
        public init(option: Option = .SHORT) {
            self.option = option
        }
    }
}
