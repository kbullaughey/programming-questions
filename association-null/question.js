(function() {

  window.App = Ember.Application.create();

  var store = DS.Store.create({
    revision: 4,
    adapter: DS.Adapter.create()
  });

})()
