TopicShowController = RouteController.extend({
  subscriptions: function () {
    this.subscribe('Photos').wait();
  },
  waitOn: function () {
    return [
      Meteor.subscribe('Topic', Router.current().params._id),
      Meteor.subscribe('UserData'),
      Meteor.subscribe('Votes'),
    ];
  },
  data: function () {
    return {
      topic: function () {
        return Topics.findOne({_id: Router.current().params._id});
      },
      voters: function () {
        var votes = Votes.find({topicId: Router.current().params._id}).fetch();
        var userIds = _.pluck(votes, "userId");
        return Meteor.users.find({_id: {$in: userIds}});
      }
    };
  },
  action: function () {
    this.render('TopicShow');
  }
});
