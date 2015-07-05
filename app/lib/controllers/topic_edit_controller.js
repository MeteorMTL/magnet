TopicEditController = RouteController.extend({
  subscriptions: function () {
  },
  waitOn: function () {
    return [
      Meteor.subscribe('Topic', this.params._id)
    ]
  },
  data: function () {
    return Topics.findOne({_id: this.params._id});
  },
  action: function () {
    this.render('TopicEdit', {});
  }
});
