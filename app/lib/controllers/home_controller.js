HomeController = RouteController.extend({
  layoutTemplate: 'MasterLayout',
  waitOn: function() {
    return [
      Meteor.subscribe('Votes'),
      Meteor.subscribe('Topics'),
      Meteor.subscribe('Photos'),
      Meteor.subscribe('UserData'),
    ];
  },
  action: function() {
    this.render('Home');
  }
});
