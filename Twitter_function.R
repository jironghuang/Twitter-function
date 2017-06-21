#Function for collecting tweets
tweet_collection = function(wd,reqURL,accessURL,authURL,consumerKey,accesstoken,accesstokensecret,consumerSecret,
                            date,tag,name_file){

#Setting working directory
setwd(wd)  
  
#Twitter authentication  
download.file(url = "http://curl.haxx.se/ca/cacert.pem",
              destfile = "cacert.pem")
setup_twitter_oauth(consumerKey, # api key
                    consumerSecret, # api secret
                    accesstoken, # access token
                    accesstokensecret # access token secret
)  

df_tweets = twListToDF(searchTwitter(tag, n = 10000, lang = 'en'))  
df_tweets$screenName = as.character(df_tweets$screenName)
users_df = lookupUsers(df_tweets$screenName)
users_df = twListToDF(users_df)

df_tweets = merge(df_tweets,users_df,by = "screenName",all.x = TRUE)  
title = paste(date,name_file,sep = "")
write.csv(df_tweets,title,row.names = FALSE)
  
}
