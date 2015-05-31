ReactionsController = RouteController.extend({
  subscriptions: function () {
    this.subscribe('Photos').wait();
  },
  waitOn: function () {
    return [
      Meteor.subscribe('Teams'),
      Meteor.subscribe('UserData'),
      Meteor.subscribe('Commitments'),
      Meteor.subscribe('Reactions')
    ];
  },
  data: function () {
    return {
      reactions: function () {
        return Reactions.find({userId: Meteor.userId()});
      }
    };
  },
  action: function () {
    this.render('Reactions', {});
  }
});
