Player.IndexRoute = Ember.Route.extend({
    model: function() {
        return ['red', 'yellow', 'blue'];
    }
});

Player.SearchRoute = Ember.Route.extend({
    model: function(){
        return [];
    },
    setupController: function(controller) {
        $.get("http://ws.spotify.com/search/1/track.json?q="+"pryda",function(data){
            var tracks = [];
            var tracksData = data.tracks;
            $(tracksData).each(function(i,elm){
                var track = $(elm)[0];
                var artists = "";
                $(track.artists).each(function(i,item){
                    artists += item.name + " ";
                });
                tracks.push({
                    name: track.name,
                    artist: artists
                });
            });
            controller.set("model", tracks);
        });
    }
});

Player.SearchController = Ember.ArrayController.extend({
    query: 'year:2014',
    actions: {
        search: function(){
            console.log("appa", this.get("query"));
        }
    }
});
