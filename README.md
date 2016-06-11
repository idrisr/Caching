# Caching

The purpose of this project is to explore how caching works in iOS. Specifically I was wondering why my HTTPS responses weren't being cached by the default iOS cache. The reason is because the response headers were missing the 'Cache-Control' header so the system would not auto cache the response.

Using Charles to inject that header field to the response proved my theory. Now responses are being cached and I can show that with this project.