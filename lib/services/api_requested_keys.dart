class ApiList {
  get baseUrl=> "https://api.giphy.com/v1/gifs/"; //production
  get apiKey=> "?api_key=rvMV2MGjtWoWuWi9k1Nihg5aPC0GkScS"; //giphy api-key
  get getTrandingGifs => "${baseUrl}trending$apiKey&offset=0&rating=g&bundle=messaging_non_clips&limit=";
  get getSearchGifs => "${baseUrl}search$apiKey&offset=0&rating=g&lang=en&bundle=messaging_non_clips&limit=";
}
ApiList apiList = ApiList();

