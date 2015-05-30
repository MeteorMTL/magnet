HomeController = RouteController.extend({
  layoutTemplate: 'MasterLayout',
  subscriptions: function () {
    this.subscribe('Photos').wait();
  },
  waitOn: function() {
    return [
      Meteor.subscribe('Votes'),
      Meteor.subscribe('Topics'),
      Meteor.subscribe('UserData'),
    ];
  },
  action: function() {
    this.render('Home');
  }
});
