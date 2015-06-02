PeopleController = RouteController.extend({
  subscriptions: function () {
    this.subscribe('Photos').wait();
    this.subscribe('Reactions').wait();
    this.subscribe('Charts').wait();
    this.subscribe('Votes').wait();
  },
  waitOn: function () {
    return [
      Meteor.subscribe('Votes'),
      Meteor.subscribe('Topics'),
      Meteor.subscribe('UserData'),
    ];
  },
  action: function () {
    this.render('People', { /* data: {} */});
  }
});
