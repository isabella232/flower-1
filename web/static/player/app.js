Player = Ember.Application.create({
    LOG_TRANSITIONS: true,
    LOG_VIEW_LOOKUPS: true
});

Player.Router.map(function() {
    // put your routes here
    this.resource('search', { path: '/search' }, function(){
        this.resource(':query');
    });
});
