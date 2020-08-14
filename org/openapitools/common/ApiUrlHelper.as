package org.openapitools.common
{
    import org.openapitools.common.ApiUserCredentials;
    import org.openapitools.common.*;

    internal class ApiUrlHelper 
    {

        private static const API_URL_KEY:String = "APIKEY";
        private static const AUTH_TOKEN_URL_KEY:String = "auth_token";
        private static const HTTP_URL_PREFIX:String = "https://";


        internal static function appendTokenInfo(restUrl:String, requestHeader:Object, credentials:ApiUserCredentials):String
        {
            if (restUrl.indexOf("?") == -1)
            {
                restUrl = (restUrl + ((("?" + API_URL_KEY) + "=") + credentials.apiToken));
            }
            else
            {
                restUrl = (restUrl + ((("&" + API_URL_KEY) + "=") + credentials.apiToken));
            };
            requestHeader[API_URL_KEY] = credentials.apiToken;
            if (((!(credentials.authToken == null)) && (!(credentials.authToken == ""))))
            {
                restUrl = (restUrl + ((("&" + AUTH_TOKEN_URL_KEY) + "=") + credentials.authToken));
                requestHeader.auth_token = credentials.authToken;
            };
            return (restUrl);
        }

        internal static function getProxyUrl(hostName:String, proxyPath:String):String
        {
            if (hostName.charAt(hostName.length) == "/")
            {
                hostName = hostName.substring(0, (hostName.length - 1));
            };
            return ((HTTP_URL_PREFIX + hostName) + proxyPath);
        }


    }
} org.openapitools.common

