(function() {

  window.App = Ember.Application.create({
    ApplicationView: Ember.View.extend({
      templateName: 'application'
    }),
    ApplicationController: Ember.Controller.extend({}),
    State1View: Ember.View.extend({
      templateName: 'state1'
    }),
    State1Controller: Ember.Controller.extend({
      theActions: ["action 1", "action 2"],     
      genericHandler: function(context) {
        if (context instanceof jQuery.Event) {
          context = context.context
        }
        console.log(context);
      }
    }),
    Router: Ember.Router.extend({
      root: Ember.Route.extend({
        state1: Ember.Route.extend({
          route: '/',
          connectOutlets: function(router) {
            router.get('applicationController').connectOutlet("main", "state1");
          }
        })
      })
    })
  });

  var store = DS.Store.create({
    revision: 4,
    adapter: DS.Adapter.create()
  });

  App.initialize();

})()
