TeamShowController = RouteController.extend({
  subscriptions: function () {
    this.subscribe('Photos').wait();
    this.subscribe('Messages').wait();
    this.subscribe('Likes').wait();
  },
  waitOn: function () {
    return [
      Meteor.subscribe('Teams'),
      Meteor.subscribe('UserData'),
      Meteor.subscribe('Messages', Router.current().params._id),
      Meteor.subscribe('Likes', Router.current().params._id)
    ];
  },
  data: function () {
    return {
      team: function () {
        return Teams.findOne({_id: Router.current().params._id});
      },
      messages: function () {
        var teamId = Router.current().params._id;
        return Messages.find({teamId: teamId}).fetch();
      }
    };
  },
  action: function () {
    this.render('TeamShow');
  }
});
