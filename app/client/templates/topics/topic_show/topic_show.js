Template.TopicShow.events({
  "click .edit": function () {
    Router.go('TopicEdit', {_id: Router.current().params._id});
  },
  "click .delete": function () {
    var topicId = Router.current().params._id;
    var votes = Votes.find({topicId: topicId});
    votes.forEach(function (vote) {
      Votes.remove({_id: vote._id});
    });
    Topics.remove({_id: topicId});
    Router.go('Home');
  }
});

Template.TopicShow.helpers({
  voters: function () {
    var topicVotes = Votes.find({_id: this.params._id})
    return Meteor.users.find({}, {sort: {lastAnnounced: -1}});
  }
});

Template.TopicShow.created = function () {
};

Template.TopicShow.rendered = function () {
};

Template.TopicShow.destroyed = function () {
};
