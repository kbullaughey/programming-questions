(function() {

  window.App = Ember.Application.create({
    rootElement: '#hook',
    store: DS.Store.create({
      revision: 4,
      adapter: DS.Adapter.create({
        find: function(store, type, id) { },
      }),
    }),
    Router: Ember.Router.extend({
      location: Ember.Location.create({
        implementation: 'none',
      }),
      root: Ember.Route.extend({
        index: Ember.Route.extend({
          route: '/',
        }),
        showBook: Ember.Route.transitionTo('book'),
        book: Ember.Route.extend({
          route: '/book',
          connectOutlets: function(router) {
            book = App.Book.find(1);
            router.get('applicationController').connectOutlet('titleOutlet', 'book', book);
            router.get('applicationController').connectOutlet('summaryOutlet', 'summary', book.get('summary'));
          },
          load: function(router) {
            App.store.load(App.Book, {id: 1, title: "Jude the Obscure", summary: {id: 1, text: "Some obscure stuff."}});
          }
        }),
        showArticle: Ember.Route.transitionTo('article'),
        article: Ember.Route.extend({
          route: '/article',
          connectOutlets: function(router) {
            App.store.load(App.Article, {id: 1, title: "Why Jude is Obscure", summary: {id: 1, text: "Dance, my darling."}});
            article = App.Article.find(1);
            router.get('applicationController').connectOutlet('titleOutlet', 'article', article);
            router.get('applicationController').connectOutlet('summaryOutlet', 'summary', article.get('summary'));
          },
        }),
      }),
    }),
  });

  /* Models */
  App.Summary = DS.Model.extend({
    text: DS.attr("string"),
  });

  App.Book = DS.Model.extend({
    title: DS.attr("string"),
    summary: DS.belongsTo(App.Summary, {embedded: true}),
  });

  App.Article = DS.Model.extend({
    title: DS.attr("string"),
    summary: DS.belongsTo(App.Summary, {embedded: true}),
  });

  /* Controllers */

  App.ApplicationController = Ember.Controller.extend();
  App.BookController = Ember.Controller.extend();
  App.ArticleController = Ember.Controller.extend();
  App.SummaryController = Ember.Controller.extend();

  /* Views */

  App.ApplicationView = Ember.View.extend({
    templateName: 'app',
  });

  App.BookView = Ember.View.extend({
    template: Ember.Handlebars.compile('<p><a href="#" {{action load}}>(load)</a> Book: {{content.title}}</p>'),
  });

  App.ArticleView = Ember.View.extend({
    template: Ember.Handlebars.compile('<p>Article: {{content.title}}</p>'),
  });

  App.SummaryView = Ember.View.extend({
    template: Ember.Handlebars.compile('<p>Summary: {{content.text}}</p>'),
  });

  App.initialize();

})();

/* END */

