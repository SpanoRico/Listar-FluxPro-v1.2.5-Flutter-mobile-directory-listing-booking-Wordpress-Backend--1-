if (self.CavalryLogger) { CavalryLogger.start_js(["HqWtw"]); }

__d("MessengerThreadSharedMediaHelper",["AsyncRequest","FBLogger","LogHistory","MercuryMessagingLightswitch","MessageSharedMediaIDStore.bs","MessengerThreadSharedMediaAfterWebGraphQLQuery","MessengerThreadSharedMediaBeforeWebGraphQLQuery","MessengerThreadSharedMediaFindWebGraphQLQuery","performanceAbsoluteNow","promiseDone"],(function(a,b,c,d,e,f){"use strict";var g,h=b("LogHistory").getInstance("shared_media_helper"),i=0;a={search:function(a,c,d){var e=b("MessageSharedMediaIDStore.bs").getMessageIDForAttachmentID(c),f=i++,j=(g||(g=b("performanceAbsoluteNow")))(),k=new(b("AsyncRequest"))(b("MessengerThreadSharedMediaFindWebGraphQLQuery").getLegacyURI({id:a,photoID:c,messageID:e}));b("MercuryMessagingLightswitch").guard(function(){h.debug("search request "+f,JSON.stringify({id:a,photoID:c,messageID:e,timestamp:j}))});b("promiseDone")(k.setAllowCrossPageTransition(!0).exec().then(function(a){return a.getPayload()}),function(i){var k=(g||(g=b("performanceAbsoluteNow")))();b("MercuryMessagingLightswitch").guard(function(){h.debug("search response "+f,JSON.stringify({id:a,photoID:c,messageID:e,timestamp:k,duration:k-j}))});d(i)},function(a){b("MercuryMessagingLightswitch").guard(function(){b("FBLogger")("messenger_shared_media").warn("Error while searching for shared media: "+a.errorDescription)})});return k},loadMorePrevious:function(a,c,d,e){a=new(b("AsyncRequest"))(b("MessengerThreadSharedMediaAfterWebGraphQLQuery").getLegacyURI({id:a,after:c,first:d}));b("promiseDone")(a.setAllowCrossPageTransition(!0).exec().then(function(a){return a.getPayload()}),function(a){return e(a)},function(a){b("MercuryMessagingLightswitch").guard(function(){b("FBLogger")("messenger_shared_media").warn("Error while fetching previous media: "+a.errorDescription)})});return a},loadMoreLatest:function(a,c,d,e){a=new(b("AsyncRequest"))(b("MessengerThreadSharedMediaBeforeWebGraphQLQuery").getLegacyURI({id:a,before:c,last:d}));b("promiseDone")(a.setAllowCrossPageTransition(!0).exec().then(function(a){return a.getPayload()}),function(a){return e(a)},function(a){b("MercuryMessagingLightswitch").guard(function(){b("FBLogger")("messenger_shared_media").warn("Error while fetching latest media: "+a.errorDescription)})});return a}};e.exports=a}),null);